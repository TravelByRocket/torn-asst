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

    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9]")
    
    var invalidCharacterFound: Bool {
        let range = NSRange(location: 0, length: apifield.utf16.count)
        return regex.firstMatch(in: apifield, options: [], range: range) != nil
    }
    
    var isWrongLength: Bool {
        apifield.count != 16
    }

    static var footer: some View {
        Text("Your API key is only stored on your device(s) to make API requests to Torn servers. The key is never shared and it cannot be used to make any changes to your account.")
            .font(.caption)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            VStack {
                BigSectionBarView(
                    systemImage: "key",
                    message: "Torn API Key",
                    color: .accentColor)
                HStack {
                    TextField("API Key", text: $apifield)
                        .textInputAutocapitalization(.never)
                        .font(.body.monospaced())
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
                    Button(action: {
                        if apifield == "" {
                            let pasteboard = UIPasteboard.general
                            apifield = pasteboard.string ?? ""
                        } else {
                            apifield = ""
                        }
                    }) {
                        Label(
                            apifield == "" ? "Paste" : "Clear",
                            systemImage: apifield == "" ? "doc.on.clipboard" : "clear"
                        )
                            .labelStyle(.iconOnly)
                            .animation(.easeInOut, value: apifield == "")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                Text("problem text")
                    .font(.footnote)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                Button(
                    action: {
                        // API fetch
                    }
                ) {
                    Text(invalidCharacterFound || isWrongLength ? "Invalid Entry" : "Submit")
                        .padding(8)
                }
                .buttonStyle(PlainButtonStyle())
                .background(Color.primary.opacity(0.1).cornerRadius(5.0))
                .disabled(invalidCharacterFound || isWrongLength)
                .animation(.default, value: invalidCharacterFound || isWrongLength)
                .padding(.bottom)
            }
            Group {
                Text("Ways to find your API Key:")
                    .bold()
                Link(
                    destination: URL(string: "https://www.torn.com/preferences.php#tab=api")!,
                    label: {
                        Label("Tap here to go directly to the API Key tab", systemImage: "target")
                    })
                Button(
                    action: {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = "https://www.torn.com/preferences.php#tab=api"
                    }) {
                        Label("Tap here to copy the URL to the clipboard", systemImage: "doc.on.doc")
                    }
                Label("On torn.com, go to \"Settings\" and then \"API Key\"", systemImage: "cursorarrow.rays")
                Label("Type this URL into your browser:\ntorn.com/preferences.php#tab=api", systemImage: "keyboard")
            }
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(.primary)
            .font(.caption)
            .padding(.horizontal)
            .padding(.vertical,1)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct ApiPromptPage_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        List {
            Section(footer: ApiPromptPage.footer) {
                ApiPromptPage()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
            }
        }
    }
}
