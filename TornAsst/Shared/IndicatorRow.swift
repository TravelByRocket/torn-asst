//
//  IndicatorRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct IndicatorRow: View {
    let name: String
    let color: Color
    let barInfo: BarResult
    let server_time: Int
    
    var curValue: Int {
        barInfo.current
    }
    
    var maxValue: Int {
        barInfo.maximum
    }
    
    var curValText: Text {
        if curValue >= 1000 {
            return Text(String(curValue))
        } else {
            return Text("\(curValue, specifier: "%4.d")")
        }
    }
    
    var maxValText: Text {
        if maxValue >= 1000 {
            return Text(String(maxValue))
        } else {
            return Text("\(maxValue, specifier: "%4.d")")
        }
    }
    
    var dateFull: Date {
        Date(timeIntervalSince1970: TimeInterval(server_time + barInfo.fulltime))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack (spacing: 0) {
                Text(name)
                curValText+Text("/")+maxValText
                Spacer()
                Text("+\(barInfo.increment, specifier: "%2.d")\(String(name.prefix(1)).lowercased())/\(barInfo.interval/60, specifier: "%2.d")min").font(.caption)
            }
            .font(.system(.body, design: .monospaced))
            .background(color.opacity(0.2))
            HStack {
                Spacer()
                if (curValue == maxValue) {
                    Text("FULL")
                        .font(.system(.body, design: .monospaced))
                } else if (curValue > maxValue) {
                    Text("OVER")
                        .font(.system(.body, design: .monospaced))
                } else {
                    Text("Full in\n\(dateFull, style: .timer)")
                        .font(.system(.caption, design: .monospaced))
                        .multilineTextAlignment(.trailing)
                }
            }
//            .foregroundColor(color).colorInvert()
            .padding(.horizontal)
            .background(
                IndicatorBar(color: color, curValue: curValue, maxValue: maxValue)
            )
        }
    }
}

struct IndicatorRow_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorRow(
            name: "Mana  ",
            color: .purple,
            barInfo: BarResult.default,
            server_time: TornResponse.default.server_time)
    }
}
