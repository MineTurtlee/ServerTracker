//
//  C(og)Manager.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 9/7/26.
//

import Foundation
@preconcurrency import Discord

actor CogManager {
    private(set) var cogs: [String: Cog] = [:]
    var bot: DiscordClient
    
    init(_ bot: DiscordClient) {
        self.bot = bot
    }
    
    func load(cog: Cog.Type) {
        let cogObj = cog.init(bot)
        cogs[String(describing: type(of: cog))] = cogObj
        Task {
            await cogObj.cog_load()
        }
    }
}
