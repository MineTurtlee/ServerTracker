//
//  Ready.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 21/6/26.
//

import Foundation
import Discord
import Logging

fileprivate let logger = Logger(label: "TrackerBot")

extension TrackerBot {
    func client(_ bot: DiscordClient, didConnect connected: Bool) {
        if bot.shardManager.shards.last?.connected ?? false != true { return }
        logger.info("Bot (iis entirely) ready! Bot info are listed below:")
        logger.info("Username: \(bot.user?.username ?? "unknown")#\(bot.user?.discriminator ?? "0")")
        logger.info("Servers: \(bot.guilds.count)")
        logger.info("")
    }
}
