//
//  LandingNoticeLabel.swift
//  TornAsst
//
//  Created by Bryan Costanza on 27 Dec 2021.
//

import SwiftUI

struct NoticeAdjustLabel: View {
    let hours: Double
    let minutes: Double
    let seconds: Double
    let variant: Variant

    enum Variant {
        case creating
        case updating
    }

    var verbPart: String {
        variant == .creating ? "Remind" : "Change to"
    }

    var hoursString: String {
        String(format: "%02d", Int(hours))
    }

    var minString: String {
        String(format: "%02d", Int(minutes))
    }

    var secString: String {
        String(format: "%02d", Int(seconds))
    }

    var body: some View {
        Label(
            "\(verbPart) \(hoursString):\(minString):\(secString) before",
            systemImage: "rectangle.stack.badge.plus")
            .monospacedDigit()
            .multilineTextAlignment(.trailing)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct LandingNoticeLabel_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            NoticeAdjustLabel(hours: 1, minutes: 2, seconds: 3, variant: .creating)
            NoticeAdjustLabel(hours: 2, minutes: 3, seconds: 4, variant: .updating)
        }
    }
}
