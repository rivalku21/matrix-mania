//
//  ANBtnView.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 17/06/23.
//

import SwiftUI

struct ANBtnView: View {
    @ObservedObject var generalData: GeneralDataFunction
    let num: [Int]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if(generalData.int[num[0]] == generalData.answr[num[0]]
                ){
                    Image("Rectangle3")
                        .resizable()
                        .frame(width: geometry.size.height, height: geometry.size.height)
                } else {
                    Image("Rectangle2")
                        .resizable()
                        .frame(width: geometry.size.height, height: geometry.size.height)
                }
                Button(action: {
                    generalData.ButtonPlusOne(numbers: num)
//                    checking()
                }, label: {
                    Text(String(generalData.int[num[0]]))
                        .font(.system(size: geometry.size.height * 0.4))
                })
                .cornerRadius(8)
            }
        }
    }
}
