//
//  ResultView.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import Foundation

import SwiftUI

struct ResultView<Label, Content>: View where Label : View, Content : View {
    let label: Label
    let content: Content
    
    init(@ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.content = content()
    }
    
    var body: some View {
        Group {
            LabeledContent {
                content
            } label: {
                label
            }
        }
    }
}

extension ResultView where Label == Text, Content == Text {
    init<S, F>(_ label: S, statistic: F.FormatInput?, format: F) where S : StringProtocol, F : FormatStyle, F.FormatInput : Equatable, F.FormatOutput == String {
        self.label = Text(label)
        
        if let statistic {
            self.content = Text(statistic, format: format)
        } else {
            self.content = Self.placeholder
        }
    }
    
    init<S>(_ label: S, statistic: S?) where S : StringProtocol {
        self.label = Text(label)
        if let statistic {
            self.content = Text(statistic).font(.headline)
        } else {
            self.content = Self.placeholder
        }
    }
    
    private static var placeholder: Text {
        Text("—")
    }
}
