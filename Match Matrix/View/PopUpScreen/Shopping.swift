//
//  Shooping.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 18/06/23.
//

import SwiftUI
import StoreKit

struct Shopping: View {
    @Binding var screen: Int
    @State private var position: CGFloat = 0.001
    @State var hint: Int = DataController().profile[0].hint!.intValue
    @StateObject var storeKit = StoreKitManager()

    var body: some View {
        Group {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        Text("Shop")
                            .foregroundStyle(.white)
                            .font(.custom("SoupofJustice", size: geometry.size.width * 0.1))

                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    screen = 1
                                }
                            } label: {
                                Image("Close")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.1)
                            }
                        }
                        .padding(geometry.size.width * 0.02)
                    }

                    VStack(spacing: 8) {
                        Text("My Bag")
                            .font(.custom("SoupofJustice", size: geometry.size.width * 0.05))
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                            .padding(.top)

                        HStack {
                            ZStack {
                                Image("Hint")
                                    .resizable()
                                    .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
                                ZStack {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(
                                            width: geometry.size.height * 0.03,
                                            height: geometry.size.height * 0.03
                                        )
                                    Circle()
                                        .stroke(lineWidth: 2.0)
                                        .fill(Color.white)
                                        .frame(
                                            width: geometry.size.height * 0.03,
                                            height: geometry.size.height * 0.03
                                        )
                                    Text("\(hint)")
                                        .font(.system(size: geometry.size.height * 0.02))
                                        .foregroundColor(.white)
                                }
                                .frame(
                                    maxWidth: geometry.size.height * 0.08,
                                    maxHeight: geometry.size.height * 0.08,
                                    alignment: .bottomTrailing
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("ECE9E7"))
                    }

                    VStack {
                        VStack(spacing: 8) {
                            HStack(spacing: 8) {
                                Spacer()

                                Image("SilverCoin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.08)
                                Text("99999")
                                    .font(.custom("SoupofJustice", size: geometry.size.width * 0.05))

                                Image("GoldCoin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.08)
                                Text("99999")
                                    .font(.custom("SoupofJustice", size: geometry.size.width * 0.05))
                            }
                            .padding(.trailing, 8)
                            .padding(.top, 8)

                            HStack(spacing: 16) {
                                shoppingCard()
                                shoppingCard()
                                shoppingCard()
                            }
                            .padding(.bottom, 8)
                            .padding(.horizontal)

                            HStack(spacing: 16) {
                                shoppingCard()
                                shoppingCard()
                                shoppingCard()
                            }
                            .padding(.bottom, 16)
                            .padding(.horizontal)
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("ECE9E7"))
                        }
                        
//                                ZStack {
//                                    Image("Hint")
//                                        .resizable()
//                                        .frame(width: geometry.size.height * 0.08, height: geometry.size.height * 0.08)
//                                    ZStack {
//                                        Circle()
//                                            .fill(Color.red)
//                                            .frame(
//                                                width: geometry.size.height * 0.03,
//                                                height: geometry.size.height * 0.03
//                                            )
//                                        Circle()
//                                            .stroke(lineWidth: 2.0)
//                                            .fill(Color.white)
//                                            .frame(
//                                                width: geometry.size.height * 0.03,
//                                                height: geometry.size.height * 0.03
//                                            )
//                                        Text("\(hint)")
//                                            .font(.system(size: geometry.size.height * 0.02))
//                                            .foregroundColor(.white)
//                                    }
//                                    .frame(
//                                        maxWidth: geometry.size.height * 0.08,
//                                        maxHeight: geometry.size.height * 0.08,
//                                        alignment: .bottomTrailing
//                                    )
//                                }
//                                ForEach(Array(storeKit.storeProducts.enumerated()), id: \.1) { index, product in
//                                    let delay = Double(index) * 0.1
//                                    ShoppingSubView(hint: $hint, product: product, delay: delay)
//                                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.05)
//                                }
                    }
                }
                .cornerRadius(20)
                .onAppear {
                    position = 1
                }
                .scaleEffect(position)
                .animation(Animation.easeInOut(duration: 0.3), value: position)
                .padding(.horizontal, geometry.size.width * 0.05)
            }
            .background {
                ZStack {
                    Image("Background4")
                        .resizable()
                    VStack {
                        Image("MatchUp")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                        Image("MatchDown")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .ignoresSafeArea()
            }
        }
    }

    func shoppingCard() -> some View {
        return VStack(spacing: 8) {
            Image("ShoppingCartBg")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Button {

            } label: {
                ZStack {
                    Image("ButtonShop")
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                    Text("0.99")
                        .font(.custom("SoupofJustice", size: 20))
                        .foregroundStyle(.white)
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
            .onAppear {
                withAnimation {
                    shouldAnimate = true
                }
            }
        }
    }
}
