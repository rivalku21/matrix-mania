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
        VStack {
            ForEach(0..<4) { rowIndex in
                HStack {
                    ForEach(0..<4) { columnIndex in
                        let index = rowIndex * 4 + columnIndex
                        ANBtnView(generalData: generalData, num: numberClickPlusOneHard[index])
                            .scaledToFit()
                    }
                }
            }
        }
    }
}
