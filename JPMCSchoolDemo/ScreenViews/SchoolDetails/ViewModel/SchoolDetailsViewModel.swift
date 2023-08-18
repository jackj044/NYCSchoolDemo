//
//  SchoolDetailsViewModel.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import Foundation
import Combine

final class SchoolDetailsViewModel: ObservableObject {
    
    @Published private(set) var examResults = [ExamResult]()
    @Published var schoolExamResult: ExamResult?
    private var cancellables = Set<AnyCancellable>()
    private let networkManager: any NetworkManagerDelegate
    
    init(networkManager: any NetworkManagerDelegate = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchExamResults(schoolDbn:String) async {
        await networkManager.request(endpoint: .examResults, httpMethod: .GET, parameters: [:], type: [ExamResult].self).sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] data  in
                self?.examResults = data
                self?.getExamResult(schoolDbn: schoolDbn)
            }
            .store(in: &cancellables)
    }
    
   private func getExamResult(schoolDbn:String) {
        schoolExamResult =  examResults.first(where: { data in
            data.dbn == schoolDbn
        })

        print(schoolExamResult.debugDescription)

    }
    
}
