//
//  HardButton.swift
//  Match Matrix
//
//  Created by Rival Fauzi on 17/06/23.
//

import SwiftUI

struct HardButton: View {
    @ObservedObject var generalData: GeneralDataFunction
    
    var body: some View {
        VStack{
            HStack{
                ANBtnView(generalData: generalData, num: [0, 1, 4])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [1, 0, 2, 5])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [2, 1, 3, 6])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [3, 2, 7])
                    .scaledToFit()
            }
            
            HStack{
                ANBtnView(generalData: generalData, num: [4, 0, 5, 8])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [5, 1, 4, 6, 9])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [6, 2, 5, 7, 10])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [7, 3, 6, 11])
                    .scaledToFit()
            }
            
            HStack{
                ANBtnView(generalData: generalData, num: [8, 4, 9, 12])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [9, 5, 8, 10, 13])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [10, 6, 9, 11, 14])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [11, 7, 10, 15])
                    .scaledToFit()
            }
            
            HStack{
                ANBtnView(generalData: generalData, num: [12, 8, 13])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [13, 9, 12, 14])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [14, 10, 13, 15])
                    .scaledToFit()
                ANBtnView(generalData: generalData, num: [15, 11, 14])
                    .scaledToFit()
            }
        }
    }
}
