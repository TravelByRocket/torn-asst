//
//  APIPrompt.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/27/20.
//

import SwiftUI

struct APIPrompt: View {
    @Binding var apikey: String
    @Binding var response: TornResponse
    @State private var apikeytry: String = ""
    @State private var errorMessage = ""
    @State private var showAPIErrorAlert = false
    @State private var loading = false
    
    let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9]")
    
    var invalidCharacterFound: Bool {
        let range = NSRange(location: 0, length: apikeytry.utf16.count)
        return regex.firstMatch(in: apikeytry, options: [], range: range) != nil
    }
    
    var isWrongLength: Bool {
        apikeytry.count != 16
    }
    
    
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            VStack {
                Text("Torn API Key Required")
                    .font(.title2)
                HStack {
                    TextField("API Key...", text: $apikeytry)
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
                    if (apikeytry == "") {
                        Button(action: {
                            let pasteboard = UIPasteboard.general
                            apikeytry = pasteboard.string ?? ""
                        }) {
                            Label("Paste", systemImage: "doc.on.clipboard")
                                .font(.title3)
                        }
                    } else {
                        Button(action: {
                            apikeytry = ""
                        }) {
                            Label("Clear", systemImage: "clear")
                                .font(.title3)
                        }
                    }
                }
                Button(action: {
                    loading = true
                    loadData()
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
                .alert(isPresented: $showAPIErrorAlert, content: {
                    Alert(title: Text("API Error"), message: Text(errorMessage))
                })
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
    
    func loadData() {
        guard let url = URL(string: "https://api.torn.com/user/?selections=basic,bars,travel&key=\(apikeytry)") else {
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
                            withAnimation(.default) {
                                apikey = apikeytry
                            }
                        } else {
                            self.errorMessage = "placeholder"
                            showAPIErrorAlert = true
                            loading = false
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

struct APIPrompt_Previews: PreviewProvider {
    static var previews: some View {
        APIPrompt(apikey: .constant(""), response: .constant(TornResponse()))
    }
}
