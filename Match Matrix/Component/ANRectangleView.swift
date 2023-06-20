//
//  ANRectangleView.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 16/06/23.
//

import Foundation
import SwiftUI

struct RectangleView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image("Rectangle1")
                .resizable()
                .frame(width: geometry.size.height, height: geometry.size.height)
                .overlay {
                    self.content
                }
                .font(.system(size: geometry.size.height * 0.4))
        }
        .scaledToFit()
    }
}
