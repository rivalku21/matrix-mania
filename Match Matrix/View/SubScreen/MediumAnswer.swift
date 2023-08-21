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
        VStack {
            ForEach(0..<3) { rowIndex in
                HStack {
                    ForEach(0..<3) { columnIndex in
                        let index = rowIndex * 3 + columnIndex
                        RectangleView {
                            Text(String(generalData.answr[index]))
                        }
                    }
                }
            }
        }
    }
}
