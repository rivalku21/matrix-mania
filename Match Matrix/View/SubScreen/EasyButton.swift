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
        VStack {
            ForEach(0..<2) { rowIndex in
                HStack {
                    ForEach(0..<2) { columnIndex in
                        let index = rowIndex * 2 + columnIndex
                        ANBtnView(generalData: generalData, num: numberClickPlusOneEasy[index])
                            .scaledToFit()
                    }
                }
            }
        }
    }
}
