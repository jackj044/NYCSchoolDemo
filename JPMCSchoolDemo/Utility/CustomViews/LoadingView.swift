//
//  LoadingView.swift
//  JPMCSchoolDemo
//
//  Created by Jatin Patel on 8/17/23.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    
    var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack(spacing: 0) {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                    Text("Loading...")
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 6)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(10)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
    
}
