//
//  SyncSection.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/28/20.
//

import SwiftUI

struct SyncSection: View {
    @Binding var response: TornResponse
    @Binding var apikey: String
    
    var dateFromServerTime: Date {
        Date.init(timeIntervalSince1970: TimeInterval(response.server_time))
    }
    
    var body: some View {
        HStack {
            VStack {
                Button(action: loadData) {
                    Label("Force Refresh", systemImage: "arrow.clockwise")
                }
                .onAppear(perform: loadData)
                .foregroundColor(.accentColor)
                Button(action: {
                    apikey = ""
                }) {
                    Label("Clear API Key", systemImage: "clear")
                }
                .foregroundColor(.orange)
            }
            Spacer()
            Button(action: {
                loadData()
            }) {
                Text("""
                    Server data from
                    \(dateFromServerTime, style: .relative) ago
                    """)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
        }
        .font(.system(.caption, design: .monospaced))
        .padding(.horizontal)
    }
    
    func loadData() {
        print("requesting from Torn")
        guard let url = URL(string: "https://api.torn.com/user/?selections=basic,bars,travel&key=\(apikey)") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(TornResponse.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        if (decodedResponse.error == nil) {
                            self.response = decodedResponse
                        } else {
                            apikey = ""
                        }
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct SyncSection_Previews: PreviewProvider {
    static var previews: some View {
        SyncSection(response: .constant(TornResponse.default), apikey: .constant("7Im0qHgainf4Xy1A"))
    }
}
