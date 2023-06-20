//
//  EasyAnswer.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 17/06/23.
//

import SwiftUI

struct EasyAnswer: View {
    @ObservedObject var generalData: GeneralDataFunction
    
    var body: some View {
        VStack{
            HStack{
                ForEach (0..<2){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
            HStack{
                ForEach (2..<4){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
        }
    }
}

//struct EasyAnswer_Previews: PreviewProvider {
//    static var previews: some View {
//        EasyAnswer()
//    }
//}
