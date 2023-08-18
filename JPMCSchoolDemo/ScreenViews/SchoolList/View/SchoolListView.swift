//
//  SchoolListView.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import SwiftUI

struct SchoolListView: View {
    @StateObject private var viewModel = SchoolListViewModel()
    @State private var hasViewAppear = false
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: viewModel.isLoading){
                List {
                    ForEach(viewModel.searchResults, id: \.dbn) { school in
                        NavigationLink {
                            SchoolDetailView(school: school)
                        } label: {
                            SchoolListCell(school: school)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("High Schools")
                .navigationBarTitleDisplayMode(.automatic)
                .task {
                    if !hasViewAppear{
                        await viewModel.fetchSchools()
                        hasViewAppear.toggle()
                    }
                    
                }
                .searchable(text: $viewModel.searchString)
            }
            
        }
    }
    
}


struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}




