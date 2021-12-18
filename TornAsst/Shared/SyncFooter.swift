//
//  SyncSection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct SyncFooter: View {
    @EnvironmentObject var us: UserState
    @AppStorage("apicheckedat") var lastCheck: Double = Date().timeIntervalSince1970
    
    var dateFromServerTime: Date {
        Date.init(timeIntervalSince1970: TimeInterval(us.stats.server_time))
    }
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    ApiManager.loadData(.saved)
                }) {
                    Label("Force Refresh", systemImage: "arrow.clockwise")
                }
                .padding(2)
                .onAppear(perform: {
                    ApiManager.loadData(.saved)
                })
                .foregroundColor(.accentColor)
                Button(action: {
                    us.activity = .apiPrompt(problem: nil)
                    UserDefaults.standard.removeObject(forKey: "apikey")
                    UserDefaults.standard.removeObject(forKey: "responsedata")
                }) {
                    Label("Clear API Key", systemImage: "clear")
                }
                .padding(2)
                .foregroundColor(.orange)
            }
            Spacer()
            Text("Checked \(Date.init(timeIntervalSince1970: lastCheck), style: .relative) ago")
                .multilineTextAlignment(.trailing)
                .foregroundColor(.secondary)
        }
        .font(.system(.caption, design: .monospaced))
        .padding(.horizontal)
    }
}

//struct SyncSection_Previews: PreviewProvider {
//    static var previews: some View {
//        SyncSection(response: .constant(TornResponse.default), apikey: .constant("7Im0qHgainf4Xy1A"))
//    }
//}
