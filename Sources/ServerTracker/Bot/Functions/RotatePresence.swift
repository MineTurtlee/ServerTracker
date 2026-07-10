//
//  Presence.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 7/7/26.
//

import Foundation
import Discord

extension DiscordActivityAssets {
    static func make(largeImage li: String? = nil, largeText lt: String? = nil, smallImage si: String? = nil, smallText st: String? = nil) -> DiscordActivityAssets? {
        var dict: [String: String] = [:]
        if let li { dict["large_image"] = li }
        if let lt { dict["large_text"] = lt }
        if let si { dict["small_image"] = si }
        if let st { dict["small_text"] = st }

        guard let data = try? JSONSerialization.data(withJSONObject: dict) else {
            return nil
        }
        return try? JSONDecoder().decode(DiscordActivityAssets.self, from: data)
    }
}

extension DiscordActivityTimestamps {
    static func make(start: Int?, end: Int?) -> DiscordActivityTimestamps? {
        var dict: [String: Int] = [:]
        if let start { dict["start"] = start }
        if let end { dict["end"] = end }

        guard let data = try? JSONSerialization.data(withJSONObject: dict) else {
            return nil
        }
        return try? JSONDecoder().decode(DiscordActivityTimestamps.self, from: data)
    }
}

extension DiscordParty {
    static func make(id: String?, sizes: [Int]?) -> DiscordParty? {
        var dict: [String: Any] = [:]
        if let id { dict["id"] = id }
        if let sizes { dict["sizes"] = sizes }

        guard let data = try? JSONSerialization.data(withJSONObject: dict) else {
            return nil
        }
        return try? JSONDecoder().decode(DiscordParty.self, from: data)
    }
}


extension TrackerBot {
    func rotatePresence(_ bot: DiscordClient) {
        let selected: Presence = self.presences.randomElement() ?? Presence()
        if selected.enabled == false { return }
        
        // let largeImage = selected.large_image
        // let smallImage = selected.small_image
        let mode = DiscordActivityType(rawValue: selected.type)
        let activity = DiscordActivity(name: selected.name, type: mode)
        // activity.assets = DiscordActivityAssets.make(largeImage: largeImage.key, largeText: largeImage.description, smallImage: smallImage.key, smallText: smallImage.description)
        // activity.details = selected.details
        // activity.state = selected.state
        
        // var start: Int? {
        //     if selected.start == 0 { return Int(self.initTime) } else { return Int(self.initTime + selected.start) }
        // } // ts is funny i jst realized i dont need it
        // activity.timestamps = DiscordActivityTimestamps.make(start: start, end: Int(self.initTime + selected.end))
        
        // activity.party = DiscordParty.make(id: "NotSwiftified_", sizes: [selected.party.current, selected.party.max])
        
        let presence = DiscordPresenceUpdate(activities: [activity], status: .idle, afkSince: Date(timeIntervalSince1970: TimeInterval(integerLiteral: initTime)))
        
        for shard in bot.shardManager.shards {
            shard.sendPayload(.presenceUpdate(presence))
        }
    }
}
