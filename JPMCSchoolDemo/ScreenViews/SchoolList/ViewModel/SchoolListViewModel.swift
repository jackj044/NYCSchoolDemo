//
//  SchoolListViewModel.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import Foundation
import SwiftUI
import Combine

class SchoolListViewModel: ObservableObject {
    @Published private(set) var schools = [School]()
    @Published var searchString = ""
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()
    private let networkManager: any NetworkManagerDelegate
    
    // Dependency Inversion through Protocol
    init(networkManager: any NetworkManagerDelegate = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // This array will filled by search result
    // if searchString is empty, then it will fill by default All School data.
    var searchResults: [School] {
        if searchString.isEmpty {
            return schools
        } else {
            return schools.filter { $0.name.contains(searchString) }
        }
    }
    
    // Given more time, I would display errors to the user in the form of an alert
    @MainActor
    func fetchSchools() async {
        isLoading = true
        await networkManager.request(endpoint: .schoolList, httpMethod: .GET, parameters: [:], type: [School].self).sink { completion in
            self.isLoading = false
            switch completion {
            case .failure(let err):
                print("Error is \(err.localizedDescription)")
            case .finished:
                print("Finished")
            }
        } receiveValue: { [weak self] data  in
            self?.schools = data
            self?.isLoading = false
        }
        .store(in: &cancellables)
    }
}
