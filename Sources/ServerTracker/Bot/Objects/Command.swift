//
//  Command.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 9/7/26.
//

import Foundation
import Discord

enum ChoiceValue: Sendable {
    case string(String)
    case int(Int)
}

protocol Command: Sendable {
    var name: String { get }
    var description: String { get } // docstring (???)
    var args: [DiscordApplicationCommandOption] { get } // None IF subcommands!
    var cog: Cog { get }
    var client: DiscordClient { get }
    var subcommands: [Subcommand] { get }
    var choices: [String: ChoiceValue] { get }
    
    func invoke_interaction(interaction: DiscordInteraction) async
    
    // Stub, override this
    // Also, please make all params _ name: Type and not named so the bot can run THAT command!
    func invoke(withContext ctx: DiscordChannel) async
}

protocol Subcommand: Command {
    var name: String { get }
    var description: String { get } // docstring (???)
    var args: [DiscordApplicationCommandOption] { get }

    var parent: Command { get } // this is the only custom field rn
    var subcommands: [Subcommand] { get }
    
    var cog: Cog { get }
    var client: DiscordClient { get }
}
