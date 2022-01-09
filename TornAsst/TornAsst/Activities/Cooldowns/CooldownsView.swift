//
//  CooldownsView.swift
//  TornAsst
//
//  Created by Bryan Costanza on 2 Jan 2022.
//

import SwiftUI

struct CooldownsView: View {
    static let tag: String = "Cooldowns"
    @State private var isLoading = false

    @EnvironmentObject var player: Player
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    var cooldowns: Cooldowns {
        player.playerCooldowns
    }

    var medical: Cooldown {
        cooldowns.cooldownMedical
    }

    var drug: Cooldown {
        cooldowns.cooldownDrug
    }

    var booster: Cooldown {
        cooldowns.cooldownBooster
    }

    var cdList: [SectionSet] {
        [
            SectionSet(cdown: drug, color: .mint, icon: "pills.fill", title: "Drug"),
            SectionSet(cdown: medical, color: .red, icon: "cross.fill", title: "Medical"),
            SectionSet(cdown: booster, color: .blue, icon: "arrowtriangle.up.circle.fill", title: "Booster")
        ]
    }

    struct SectionSet: Identifiable {
        let cdown: Cooldown
        let color: Color
        let icon: String
        let title: String

        var id: String { title }
    }

    var refreshButton: some View {
        Button {
            fetchCooldowns()
        } label: {
            HStack {
                Text("Refresh")
                if isLoading {
                    ProgressView()
                }
            }
            .foregroundColor(.indigo)
        }
    }

    var body: some View {
        Form {
#if DEBUG
            refreshButton
#endif
            ForEach(cdList) { section in
                Section {
                    BigSectionBarView(
                        systemImage: section.icon,
                        message: section.title,
                        color: section.color,
                        date: section.cdown.completion)
                    NotificationHandlingPreferenceView(
                        color: section.color,
                        handling: section.cdown.cooldownNoticeHandling)
                    ForEach(section.cdown.cooldownNotices) { notice in
                        NoticeAdjustRow(notice: notice)
                    }
                    NoticeAdjustRow(parent: section.cdown)
                }
            }
        }
        .refreshable {
            fetchCooldowns()
        }
    }

    func fetchCooldowns() {
        Task.init {
            isLoading = true
            let result = try await player.playerAPI.getNew(Cooldowns.JSON.self)
            withAnimation {
                cooldowns.setFromJSON(result)
            }
            player.objectWillChange.send()
            isLoading = false
            dataController.save()
        }
    }
}

struct CooldownsView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        CooldownsView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .environmentObject(Player.example)
    }
}
