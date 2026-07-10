//
//  Cog.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 9/7/26.
//

import Foundation
import Discord

// I keep vibecoding
protocol Cog: Actor { // xd it couldve been an actress (what a horrible joke!)
    nonisolated var bot: DiscordClient! { get }
    var commands: [Command] { get set }
    
    init(_ bot: DiscordClient)
    
    func cog_load() async
}

// MARK: only use with classes, structs = ded
extension Cog {
    /* static func make(_ bot: DiscordClient) -> Self {
        Self.init(bot)
    } */
    
    func cog_load() async {
        print("Bot test: \(String(describing: bot.user?.id))")
    }
}
