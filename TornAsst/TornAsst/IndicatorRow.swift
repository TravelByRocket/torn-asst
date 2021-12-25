//
//  IndicatorRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

// swiftlint:disable all
import SwiftUI

struct IndicatorRow: View {
    let name: String
    let color: Color
    let server_time: Int
    
    var curValue: Int {
        50
    }
    
    var maxValue: Int {
        100
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
        Date(timeIntervalSince1970: TimeInterval(TimeInterval(server_time) + TimeInterval(1000)))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack (spacing: 0) {
                Text(name)
                curValText+Text("/")+maxValText
                Spacer()
                Text("+\(215, specifier: "%2.d")/\(350.0/60, specifier: "%2.f")min").font(.system(.caption, design: .monospaced))
                    // \(String(name.prefix(1)).lowercased()) use this for first letter
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
            server_time: Int(Date().timeIntervalSince1970) - 20
        )
            .previewLayout(.sizeThatFits)
    }
}
