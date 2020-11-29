//
//  IndicatorBar.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct IndicatorBar: View {
    let color: Color
    let curValue: Int
    let maxValue: Int
    
    var ratio: CGFloat {
        let max: CGFloat = 1.00
        let val: CGFloat = CGFloat(curValue) / CGFloat(maxValue)
        return min(val,max) // do not go past 1, even though it hasn't caused rendering issue
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(.secondary)
            .overlay(
                GeometryReader {geo in
                    HStack (spacing: 0) {
                        Rectangle()
                            .foregroundColor(color)
                            .frame(width: geo.size.width * ratio)
                        Spacer().frame(minWidth: 0) // force bar to left but don't leave a gap
                    }
                }
            )
    }
}

struct IndicatorBar_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorBar(color: .green, curValue: 75, maxValue: 100).frame(height: 50)
    }
}
