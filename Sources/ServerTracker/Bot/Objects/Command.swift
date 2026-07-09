//
//  Command.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 9/7/26.
//

import Foundation
import Discord

protocol Command {
    var name: String { get }
    var description: String { get } // docstring (???)
    var args: [DiscordApplicationCommandOption] { get }
    
    func invoke_interaction(interaction: DiscordInteraction)
    
    // Stub, override this
    // Also, please make all params _ name: Type and not named so the bot can run THAT command!
    func invoke(_ name: Any)
}
