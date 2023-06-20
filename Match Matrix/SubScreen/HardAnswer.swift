//
//  HardAnswer.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 17/06/23.
//

import SwiftUI

struct HardAnswer: View {
    @ObservedObject var generalData: GeneralDataFunction
    
    var body: some View {
        VStack{
            HStack{
                ForEach (0..<4){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
            HStack{
                ForEach (4..<8){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
            HStack{
                ForEach (8..<12){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
            HStack{
                ForEach (12..<16){ index in
                    RectangleView{
                        Text(String(generalData.answr[index]))
                    }
                }
            }
        }
    }
}
