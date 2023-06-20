//
//  Shooping.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/06/23.
//

import SwiftUI
import StoreKit

struct Shopping: View {
    @Binding var isShop: Bool
    @State private var position: CGFloat = 0.001
    
    @State var hint: Int = DataController().profile[0].hint!.intValue
    
    @StateObject var storeKit = StoreKitManager()

    var body: some View{
        Group {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack{
                        ZStack {
                            VStack{
                                ZStack {
                                    Image("Hint")
                                        .resizable()
                                        .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                                    
                                    ZStack {
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: geometry.size.height * 0.03, height: geometry.size.height * 0.03)
                                        
                                        Circle()
                                            .stroke(lineWidth: 2.0)
                                            .fill(Color.white)
                                            .frame(width: geometry.size.height * 0.03, height: geometry.size.height * 0.03)
                                        
                                        Text("\(hint)")
                                            .font(.system(size: geometry.size.height * 0.02))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: geometry.size.height * 0.08, maxHeight: geometry.size.height * 0.08, alignment: .bottomTrailing)
                                }
                                
                                ForEach(Array(storeKit.storeProducts.enumerated()), id: \.1) { index, product in
                                    let delay = Double(index) * 0.1
                                    
                                    ShoppingSubView(hint:$hint, product: product, delay: delay)
                                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.05)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(geometry.size.width * 0.01)
                            
                            HStack {
                                Button {
                                    withAnimation{
                                        isShop.toggle()
                                    }
                                } label: {
                                    Image("Close")
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.08, height: geometry.size.width * 0.08)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(geometry.size.width * 0.01)
                        }
                    }
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.8, alignment: .center)
                    .background {
                        Image("Background2")
                            .resizable()
                    }
                    .cornerRadius(20)
                    .onAppear{
                        position = 1
                    }
                    .scaleEffect(position)
                    .animation(Animation.easeInOut(duration: 0.3), value: position)
                }
            }
        }
    }
}

struct ShoppingSubView: View {
    @Binding var hint: Int
    @StateObject var storeKit = StoreKitManager()
    var product: Product
    var delay: Double
    
    @State private var shouldAnimate = false
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                Task {
                    try await storeKit.purchase(product)
                    
                    await hint = DataController().profile[0].hint!.intValue
                }
            } label: {
                ZStack {
                    Image("TableLong")
                        .resizable()
                    HStack {
                        Text(product.displayName)
                        Spacer()
                        Text(product.displayPrice)
                    }
                    .padding(.horizontal)
                    .font(.system(size: geometry.size.height * 0.4))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                }
            }
            .offset(x: shouldAnimate ? 0 : -100)
            .animation(
                Animation.interpolatingSpring(mass: 1, stiffness: 50, damping: 10, initialVelocity: 0)
                                    .delay(delay)
            )
            .onAppear{
                withAnimation {
                    shouldAnimate = true
                }
            }
        }
    }
}
