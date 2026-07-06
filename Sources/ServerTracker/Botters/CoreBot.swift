//
//  CoreBot.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 21/6/26.
//

import Foundation
import Discord

class TrackerBot: DiscordClientDelegate {
    private var bot: DiscordClient!
    
    init(token: String) {
        bot = DiscordClient(token: "Bot \(token)",
                            delegate: self,
                            configuration: [
                                .intents(.allIntents),
                                .shardingInfo(try! DiscordShardInformation(shardRange: 1..<10, totalShards: 10))
                            ]
        )
    }
    
    func start() {
        bot.connect()
    }
}
