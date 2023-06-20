//
//  MendiumAnswer.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 17/06/23.
//

import SwiftUI

struct MediumAnswer: View {
    @ObservedObject var generalData: GeneralDataFunction
    
    var body: some View {
        VStack{
            HStack{
                ForEach (0..<3){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
            HStack{
                ForEach (3..<6){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
            HStack{
                ForEach (6..<9){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
        }
    }
}
