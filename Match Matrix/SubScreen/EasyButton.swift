//
//  EasyButton.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 17/06/23.
//

import SwiftUI

struct EasyButton: View {
    @ObservedObject var generalData: GeneralDataFunction
    
    var body: some View {
        VStack{
            HStack{
                ANBtnView(generalData: generalData, num: [0, 1, 2])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [1, 0, 3])
                    .scaledToFit()
            }
            
            HStack{
                ANBtnView(generalData: generalData, num: [2, 0, 3])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [3, 1, 2])
                    .scaledToFit()
            }
        }
    }
}
