//
//  MediumButton.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 17/06/23.
//

import SwiftUI

struct MediumButton: View {
    @ObservedObject var generalData: GeneralDataFunction
    
    var body: some View {
        VStack{
            HStack{
                ANBtnView(generalData: generalData, num: [0, 1, 3])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [1, 0, 2, 4])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [2, 1, 5])
                    .scaledToFit()
            }
            
            HStack{
                ANBtnView(generalData: generalData, num: [3, 0, 4, 6])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [4, 1, 3, 5, 7])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [5, 2, 4, 8])
                    .scaledToFit()
            }
            
            HStack{
                ANBtnView(generalData: generalData, num: [6, 3, 7])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [7, 4, 6, 8])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [8, 5, 7])
                    .scaledToFit()
            }
        }
    }
}
