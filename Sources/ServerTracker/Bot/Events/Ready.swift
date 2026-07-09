//
//  Ready.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 21/6/26.
//

import Foundation
import Dispatch
@preconcurrency import Discord
import Logging

fileprivate let logger = Logger(label: "TrackerBot")

extension TrackerBot {
    func client(_ bot: DiscordClient, didConnect connected: Bool) {
        for shard in bot.shardManager.shards {
            if shard.connected == false { return }
        }
        
        logger.info("Bot (iis entirely) ready! Bot info are listed below:")
        logger.info("Username: \(bot.user?.username ?? "unknown")#\(bot.user?.discriminator ?? "0")")
        logger.info("Servers: \(bot.guilds.count)")
        logger.info("")
        
        cogManager = CogManager(bot)
        loadCogs()
        
        queue = DispatchQueue(label: "PresenceRotater", attributes: .concurrent)
        timer = DispatchSource.makeTimerSource(queue: queue)
        
        timer!.schedule(deadline: .now(), repeating: 60, leeway: .seconds(1))
        timer!.setEventHandler { [weak self] in
            self!.rotatePresence(bot)
        }
        
        timer!.resume()
    }
}
