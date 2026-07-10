//
//  Ping.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 9/7/26.
//

import Foundation
@preconcurrency import Discord
import Logging

actor PingPong: Cog {
    var commands: [any Command] = []
    nonisolated let bot: DiscordClient!
    private let logger = Logger(label: "PingPongCog")
    
    init(_ bot: DiscordClient) {
        self.bot = bot
    }
    
    func cog_load() async {
        commands.append(Ping(cog: self))
        print("This cog was loaded")
    }
}
