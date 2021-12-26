//
//  APIPrompt.swift
//  TornAsst
//
//  Created by Bryan Costanza on 11/27/20.
//

// swiftlint:disable all
import SwiftUI

struct ApiPromptPage: View {
    @State private var keyText: String = ""
    @State private var loading = false

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9]")

    var api: API {
        player.playerAPI
    }

    var invalidCharacterFound: Bool {
        let range = NSRange(location: 0, length: keyText.utf16.count)
        return regex.firstMatch(in: keyText, options: [], range: range) != nil
    }
    
    var isWrongLength: Bool {
        keyText.count != 16
    }

    static var footer: some View {
        Text("Your API key is only stored on your device(s) to make API requests to Torn servers. The key is never shared and it cannot be used to make any changes to your account.")
            .font(.caption)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var body: some View {
        VStack (alignment: .leading){
            VStack {
                BigSectionBarView(
                    systemImage: "key",
                    message: "Torn API Key",
                    color: .accentColor)
                HStack {
                    TextField("API Key", text: $keyText)
                        .textInputAutocapitalization(.never)
                        .font(.body.monospaced())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.primary)
                        .onAppear(perform: {
                            keyText = api.apiKey
                        })
                        .overlay(
                            HStack{
                                Spacer()
                                if loading {
                                    ProgressView().padding(.trailing)
                                }
                            }
                        )
                    Button(action: {
                        if keyText == "" {
                            let pasteboard = UIPasteboard.general
                            keyText = pasteboard.string ?? ""
                        } else {
                            keyText = ""
                        }
                    }) {
                        Label(
                            keyText == "" ? "Paste" : "Clear",
                            systemImage: keyText == "" ? "doc.on.clipboard" : "clear"
                        )
                            .labelStyle(.iconOnly)
                            .animation(.easeInOut, value: keyText == "")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                Text(api.error ?? " ")
                    .font(.footnote)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                Button(
                    action: {
                        loading = true
                        api.key = keyText
                        Task.init {
                            let basics = try? await api.getNew(BasicsJSON.self)
                            if basics != nil {
                                player.objectWillChange.send()
                                api.lastChecked = Date()
                                api.error = nil
                                api.player?.playerBasics.level = Int16(basics!.level)
                                api.player?.playerBasics.name = basics!.name
                                api.player?.playerBasics.gender = basics!.gender
                                api.player?.playerBasics.userID = Int32(basics!.player_id)
                            }
                        }
                        loading = false
                        dataController.save()
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
                    .environmentObject(Player.example)
            }
        }
    }
}
