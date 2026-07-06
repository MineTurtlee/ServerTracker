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
        logger.info("Bot ready! Bot info are listed below:")
        logger.info("Username: \(String(describing: bot.user?.username))#\(String(describing: bot.user?.discriminator))")
        logger.info("Servers: \(bot.guilds.count)")
        logger.info("")
    }
}
