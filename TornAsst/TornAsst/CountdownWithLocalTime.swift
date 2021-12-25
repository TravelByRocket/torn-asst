//
//  CountdownWithLocalTime.swift
//  TornAsst
//
//  Created by Bryan Costanza on 15 Dec 2021.
//

import SwiftUI

struct CountdownWithLocalTime: View {
    let date: Date

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = .autoupdatingCurrent
        return formatter
    }

    var body: some View {
        HStack {
            Text(date, style: .timer)
            Image(systemName: "bolt.horizontal.fill")
            Text("\(date, formatter: DateFormatter.shortTimeOnly) \(TimeZone.autoupdatingCurrent.abbreviation() ?? "")")
        }
        .monospacedDigit()
    }
}

struct CountdownWithLocalTime_Previews: PreviewProvider {
    static var previews: some View {
        CountdownWithLocalTime(date: Date.nextCloseOfBusiness)
            .previewLayout(.sizeThatFits)
    }

}
