//
//  CoreBot.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 21/6/26.
//

import Foundation
@preconcurrency import Discord
import Dispatch

class TrackerBot: DiscordClientDelegate {
    internal var bot: DiscordClient!
    var prefix: String
    var presences: [Presence]
    var initTime: Int64
    var cogManager: CogManager?
    
    var queue: DispatchQueue? = nil
    var timer: DispatchSourceTimer? = nil
    
    init(token: String, prefix command_prefix: String, presences presencee: [Presence]) {
        prefix = command_prefix
        presences = presencee
        initTime = Int64(Date().timeIntervalSince1970)
        bot = DiscordClient(token: "Bot \(token)",
                            delegate: self,
                            configuration: [
                                .intents(.allIntents),
                                .shardingInfo(try! DiscordShardInformation(shardRange: 0..<10, totalShards: 10))
                            ]
        )
    }
    
    func start() {
        bot.connect()
    }
}
