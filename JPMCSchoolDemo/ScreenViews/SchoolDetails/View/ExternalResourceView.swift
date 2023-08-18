//
//  ExternalResourceView.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import SwiftUI

struct ExternalResourceView: View {
    
    var title: String
    var ImageName:String
    var url:URL
    var body: some View {
        Link(destination: url) {
            HStack {
                Image(systemName: ImageName)
                    .imageScale(.large)
                    .fontWeight(.light)
                    .foregroundStyle(Color.publicNavy)
                    .frame(width: 40, height: 40)
                Text(title)
                    .underline()
            }
        }
    }
}

struct ExternalResourceView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalResourceView(title: "Map", ImageName: "map.fill",url: URL(string: "tel:+19849006565")!)
    }
}
