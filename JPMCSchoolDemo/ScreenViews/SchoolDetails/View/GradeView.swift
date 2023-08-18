//
//  GradeView.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import Foundation
import SwiftUI

struct GradeView: View {
    var title: String
    var value:String?

    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
                            .frame(width: 100, height: 80)
                            .background(SwiftUI.Color.white)
            
            VStack(alignment: .center) {
                Text(title)
                Spacer()
                Text(value ?? "-")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.nycGreen)
            }.padding()
            
        }
        
    }
}
