//
//  APIPrompt.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/27/20.
//

// swiftlint:disable all
import SwiftUI

struct ApiPromptPage: View {
    @AppStorage("apikey") var apikey: String = ""
    @State private var apifield: String = ""
    @State private var loading = false
    
    @EnvironmentObject var us: UserState
    
    let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9]")
    
    var invalidCharacterFound: Bool {
        let range = NSRange(location: 0, length: apifield.utf16.count)
        return regex.firstMatch(in: apifield, options: [], range: range) != nil
    }
    
    var isWrongLength: Bool {
        apifield.count != 16
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            VStack {
                Text("Torn API Key Required")
                    .font(.title2)
                HStack {
                    TextField("API Key...", text: $apifield)
                        .font(.system(.title3, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.primary)
                        .overlay(
                            HStack{
                                Spacer()
                                if loading {
                                    ProgressView().padding(.trailing)
                                }
                            }
                        )
                    
                    if (apifield == "") {
                        Button(action: {
                            let pasteboard = UIPasteboard.general
                            apifield = pasteboard.string ?? ""
                        }) {
                            Label("Paste", systemImage: "doc.on.clipboard")
                                .font(.title3)
                        }
                    } else {
                        Button(action: {
                            apifield = ""
                        }) {
                            Label("Clear", systemImage: "clear")
                                .font(.title3)
                        }
                    }
                }
                
                if case .apiPrompt(problem: let problem) = us.activity {
                    if let details = problem?.error {
                        Text("API Code \(details.code): \(details.error)")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundColor(
                                Color.init(
                                    red: 1.00,
                                    green: 0.25,
                                    blue: 0.00)
                        )
                    }
                }
                
                Button(action: {
                    ApiManager.loadData(.check(key: apifield))
                    UserDefaults.standard.set(apifield, forKey: "apikey")
                }) {
                    if (invalidCharacterFound || isWrongLength) {
                        Text("Invalid Entry").padding(8)
                    } else {
                        Text("Submit").padding(8)
                    }
                }
                .background(Color.primary.opacity(0.1).cornerRadius(5.0))
                .disabled(invalidCharacterFound || isWrongLength)
                .animation(.default)
            }
            .padding(.horizontal)
            .padding(.bottom,50)
            Group {
                Text("Ways to get your API Key:").bold()
                Link(destination: URL(string: "https://www.torn.com/preferences.php#tab=api")!, label: {
                    Label("Tap here to go directly to the API Key tab", systemImage: "target")
                })
                Button(action: {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = "https://www.torn.com/preferences.php#tab=api"
                }) {
                    Label("Tap here to copy the URL to the clipboard", systemImage: "doc.on.doc")
                }
                Label("On torn.com, go to \"Settings\" and then \"API Key\"", systemImage: "cursorarrow.rays")
                Label("Type this URL into your browser:\ntorn.com/preferences.php#tab=api", systemImage: "keyboard")
            }
            .foregroundColor(.primary)
            .font(.caption)
            .padding(.horizontal)
            .padding(.vertical,1)
            Spacer()
            VStack {
                Text("Your API key is only stored on this device to make API requests to Torn servers. The key is never shared in any way and cannot be used to make any changes to your account.")
                    .italic()
                    .foregroundColor(.secondary)
                //                    .multilineTextAlignment(.center)
                Link("Torn API Documentation", destination: URL(string: "https://www.torn.com/api.html#")!)
                    .padding(5)
            }
            .padding()
            .font(.caption)
            Spacer()
        }
    }
}

//struct APIPrompt_Previews: PreviewProvider {
//    static var previews: some View {
//        APIPrompt(apikey: .constant(""), response: .constant(TornResponse()))
//    }
//}
