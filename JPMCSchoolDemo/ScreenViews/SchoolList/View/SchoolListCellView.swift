//
//  SchoolListCell.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import Foundation

import SwiftUI

struct SchoolListCell: View {
    let school: School
    
    var body: some View {
        HStack {
            Image("school")
                .resizable()
                .scaledToFill()
                .frame(width: 60,height: 60)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1)
                )
            
                
            Text(school.name)
                .lineLimit(3)
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.publicNavy)
                .padding()
        }
        
    }
}

struct SchoolListCell_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListCell(school: School.sampleData[0])
    }
}
