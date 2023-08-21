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
        VStack {
            ForEach(0..<4) { rowIndex in
                HStack {
                    ForEach(0..<4) { columnIndex in
                        let index = rowIndex * 4 + columnIndex
                        RectangleView {
                            Text(String(generalData.answr[index]))
                        }
                    }
                }
            }
        }
    }
}
