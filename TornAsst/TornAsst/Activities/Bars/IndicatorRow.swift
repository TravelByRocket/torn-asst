//
//  IndicatorRow.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

// swiftlint:disable all
import SwiftUI

struct IndicatorRow: View {
    let color: Color
    let bar: Bar
    
    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var curValue: Int {
        bar.barCurrent
    }
    
    var maxValue: Int {
        bar.barMaximum
    }
    
    var curValText: Text {
        if curValue >= 1000 {
            return Text(String(curValue))
        } else {
            return Text("\(curValue, specifier: "%5d")")
        }
    }
    
    var maxValText: Text {
        if maxValue >= 1000 {
            return Text(String(maxValue))
        } else {
            return Text("\(maxValue, specifier: "%d")")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack (spacing: 0) {
                Text(bar.barName)
                curValText+Text("/")+maxValText
                Spacer()
                Text("+\(bar.barIncrement, specifier: "%d")/\(bar.barInterval/60, specifier: "%-2d")min").font(.system(.caption, design: .monospaced))
                    // \(String(name.prefix(1)).lowercased()) use this for first letter
            }
            .font(.system(.body, design: .monospaced))
            .background(color.opacity(0.2))
            HStack {
                Spacer()
                if (bar.isFull) {
                    Text("FULL")
                        .font(.system(.body, design: .monospaced))
                } else if (bar.isOverFull) {
                    Text("OVER")
                        .font(.system(.body, design: .monospaced))
                } else {
                    Text("Full in\n\(bar.barFull, style: .timer)")
                        .font(.system(.caption, design: .monospaced))
                        .multilineTextAlignment(.trailing)
                }
            }
            .padding(.horizontal)
            .background(
                IndicatorBar(color: color, curValue: curValue, maxValue: maxValue)
            )
        }
    }
}

struct IndicatorRow_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        IndicatorRow(
            color: .purple,
            bar: Bar.exampleEnergy
        )
            .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .environmentObject(Player.example)
    }
}
