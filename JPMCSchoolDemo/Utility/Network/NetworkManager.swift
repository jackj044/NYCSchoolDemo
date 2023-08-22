//
//  NetworkManager.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import Foundation
import Combine

//    schoolURL : "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
//    ExamResultsURL : "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"

enum Endpoint: String {
    case schoolList = "s3k6-pzi2.json"
    case examResults = "f9bf-2cp4.json"
}

enum HttpMethods: String {
    case GET
    case POST
}


protocol NetworkManagerDelegate:AnyObject {
    func request<T: Decodable>(endpoint: Endpoint,httpMethod:HttpMethods, parameters: [String: Any], type: T.Type) async -> Future<T, Error>
}

class NetworkManager: NetworkManagerDelegate {
    static let shared = NetworkManager()
       
       private init() {
           
       }
       
       private var cancellables = Set<AnyCancellable>()
       private let baseURL = "https://data.cityofnewyork.us/resource/"
       
       
       /// generic method which is accept
       /// Endpoint
       /// HTTP Method
       /// Model Type which is generic

       func request<T: Decodable>(endpoint: Endpoint,httpMethod:HttpMethods, parameters: [String: Any], type: T.Type) async -> Future<T, Error> {
           return Future<T, Error> { [weak self] promise in
               guard let self1 = self, let url = URL(string: self1.baseURL.appending(endpoint.rawValue)) else {
                   return promise(.failure(NetworkError.invalidURL))
               }
               
               var request = URLRequest(url: url)
               request.httpMethod = httpMethod.rawValue
               
               if httpMethod == .GET {
                   let queryItems = parameters.map { key, value in
                       URLQueryItem(name: key, value: "\(value)")
                   }
                   if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                       urlComponents.queryItems = queryItems
                       request.url = urlComponents.url
                   }
               }
               
               //            debugPrint("URL is \(String(describing: request.urlRequest?.url?.absoluteString))")
               URLSession.shared.dataTaskPublisher(for: (request))
                   .tryMap { (data, response) -> Data in
                       guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                           throw NetworkError.responseError
                       }
                       return data
                   }
                   .decode(type: T.self, decoder: JSONDecoder())
                   .receive(on: RunLoop.main)
                   .sink(receiveCompletion: { (completion) in
                       if case let .failure(error) = completion {
                           switch error {
                           case let decodingError as DecodingError:
                               promise(.failure(decodingError))
                           case let apiError as NetworkError:
                               promise(.failure(apiError))
                           default:
                               promise(.failure(NetworkError.unknown))
                           }
                       }
                   }, receiveValue: { value in
                       debugPrint("Response : =============\(value)=============")
                       promise(.success(value))
                   })
                   .store(in: &self1.cancellables)
           }
       }
   }


   enum NetworkError: Error {
       case invalidURL
       case responseError
       case unknown
   }

   extension NetworkError: LocalizedError {
       var errorDescription: String? {
           switch self {
           case .invalidURL:
               return NSLocalizedString("Invalid URL", comment: "Invalid URL")
           case .responseError:
               return NSLocalizedString("Unexpected status code", comment: "Invalid response")
           case .unknown:
               return NSLocalizedString("Unknown error", comment: "Unknown error")
           }
       }
   }
