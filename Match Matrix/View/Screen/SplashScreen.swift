//
//  SplashScreen.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 08/08/23.
//

import SwiftUI

struct SplashScreen: View {
    let namespace: Namespace.ID
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("Icon")
                    .resizable()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                    .matchedGeometryEffect(id: "icon", in: namespace)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}
