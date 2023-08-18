//
//  SchoolDetailView.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import SwiftUI

struct SchoolDetailView: View {
    @StateObject private var viewModel = SchoolDetailsViewModel()
    @State private var overviewExpanded = false // This var will use for check overview is expended or not
    let school: School
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                schoolNameHeader
                overview
                basicStats
                examResults
                contact
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
        .task {
            await viewModel.fetchExamResults(schoolDbn: school.dbn)
        }
        .navigationTitle(school.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - schoolNameHeader
    
    var schoolNameHeader: some View {
        
        VStack {
            
            Image("school")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width,height: 200)
            
            VStack(spacing: 0) {
                Text(school.name)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.publicNavy)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Divider()
            }
        }
    }
    
    // MARK: - schoolNameHeader
    
    var overview: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let overview = school.overview {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Overview")
                        .textCase(.uppercase)
                        .font(.headline)
                        .foregroundColor(.publicNavy)
                    VStack(alignment: .trailing, spacing: 8) {
                        Text(overview)
                            .foregroundColor(.publicNavy)
                            .multilineTextAlignment(.leading)
                            .lineLimit(overviewExpanded ? Int.max : 5)
                        Button(overviewExpanded ? "Less" : "More") {
                            withAnimation {
                                overviewExpanded.toggle()
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    // MARK: - Basic Status
    @ViewBuilder
    var basicStats: some View {
        Divider()
        HStack {
            
            VStack{
                ResultView("Borough", statistic: school.borough?.localizedCapitalized.trimmingCharacters(in: .whitespacesAndNewlines))
                ResultView("Students", statistic: school.totalStudents, format: .number.notation(.compactName))
            }.padding(10)
            Divider()
            VStack{
                ResultView("Grad. rate", statistic: school.graduationRate, format: .percent.rounded(rule: .up, increment: 1))
                ResultView("Attend. rate", statistic: school.attendanceRate, format: .percent.rounded(rule: .up, increment: 1))
            }.padding(10)
            
            
            
        }.padding()
        
    }
    
    // MARK: - Exam Result Status
    
    @ViewBuilder
    var examResults: some View {
        Divider()
        VStack(alignment: .leading, spacing: 16) {
            Text("SAT Scores")
                .textCase(.uppercase)
                .font(.headline)
                .foregroundColor(.publicNavy)
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack{
                    HStack(alignment: .bottom, spacing: 20) {
                        GradeView(title: "Reading",value: viewModel.schoolExamResult?.satCriticalReadingAvgScore)
                        GradeView(title: "Math",value: viewModel.schoolExamResult?.satMathAvgScore)
                        GradeView(title: "Writing",value: viewModel.schoolExamResult?.satWritingAvgScore)
                        
                    }
                }
            }
        }
        .padding()
    }
    
    // MARK: - Contact
    
    var contact: some View {
        
        VStack(alignment: .leading) {
            Text("Contact")
                .textCase(.uppercase)
                .font(.headline)
                .foregroundColor(.publicNavy)
            if let website = school.website, let url = URL(string: website) {
                ExternalResourceView(title: website, ImageName: "link", url: url)
                
            }
            
            if let email = school.email, let url = URL(string: "mailto:\(email)") {
                ExternalResourceView(title: email, ImageName: "envelope.fill", url: url)
                
            }
            
            if let phone = school.phoneNumber, let url = URL(string: "tel:\(phone)") {
                ExternalResourceView(title: phone, ImageName: "phone.fill", url: url)
            }
            
            if let latitude = school.latitude, let longitude = school.longitude {
                var urlComponents = URLComponents(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)&z=18")
                let _ = urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: school.name))
                
                if let url = urlComponents?.url {
                    ExternalResourceView(title: "Click Here for Address", ImageName: "map.fill", url: url)
                }
            }
        }
        .padding()
    }
    
}

struct SchoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SchoolDetailView(school: School.sampleData[1])
        }
    }
}
