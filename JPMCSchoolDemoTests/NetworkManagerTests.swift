//
//  NetworkManagerTests.swift
//  JPMCSchoolDemoTests
//
//  Created by Jatin Patel on 8/21/23.
//

import XCTest
import Combine
@testable import JPMCSchoolDemo


final class NetworkManagerTests: XCTestCase{
    
    private var cancellables = Set<AnyCancellable>()
    
    private var schoolVM = SchoolListViewModel(networkManager: NetworkManager.shared)

    func testSchoolAPICallWithVlaidResponse() async{
//        await NetworkManager.shared.request(endpoint: .schoolList, httpMethod: .GET, parameters: [:], type: [School].self).sink { completion in
//
//            switch completion {
//            case .failure(let err):
//                print("Error is \(err.localizedDescription)")
//            case .finished:
//                print("Finished")
//            }
//        } receiveValue: { data  in
//            XCTAssertNotNil(data)
//        }
//        .store(in: &cancellables)
        await schoolVM.fetchSchools()
    }

}
