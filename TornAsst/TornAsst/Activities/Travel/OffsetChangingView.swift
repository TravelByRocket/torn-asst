//
//  OffsetChangingView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 27 Dec 2021.
//

import SwiftUI

/// Use a negative value to hide the slider
struct OffsetChangingView: View {
    @Binding var seconds: Double
    @Binding var minutes: Double
    @Binding var hours: Double

    var body: some View {
        VStack {
            if seconds >= 0.0 {
                HStack {
                    Text("\(Int(seconds), specifier: "% 2d") sec")
                    Slider(value: $seconds, in: 0 ... 59, step: 1.0)
                }
            }
            if minutes >= 0.0 {
                HStack {
                    Text("\(Int(minutes), specifier: "% 2d") min")
                    Slider(value: $minutes, in: 0 ... 59, step: 1.0)
                }
            }
            if hours >= 0.0 {
                HStack {
                    Text("\(Int(hours), specifier: "% 2d")  hr")
                    Slider(value: $hours, in: 0 ... 23, step: 1.0)
                }
            }
        }
        .font(.body.monospaced())
    }
}

struct OffsetChangingView_Previews: PreviewProvider {
    @State static var seconds = 0.0
    @State static var minutes = 0.0
    @State static var hours = 0.0

    static var previews: some View {
        Form {
//            DisclosureGroup(offset.debugDescription, isExpanded: .constant(true)) {
//                OffsetChangingView(offset: $offset)
//            }
//            Text(offset.debugDescription)
//            Stepper("offset", value: $offset)
//            Slider(value: $offset, in: 0 ... 59, step: 1.0)
            OffsetChangingView(seconds: $seconds, minutes: $minutes, hours: $hours)
            OffsetChangingView(seconds: $seconds, minutes: $minutes, hours: .constant(-1))
        }
    }
}
