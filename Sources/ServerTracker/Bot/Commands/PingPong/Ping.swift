//
//  Ping.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 10/7/26.
//

import Foundation
@preconcurrency import Discord

final class Ping: Command {
    let subcommands: [any Subcommand] = []
    
    let name: String = "ping"
    let description: String = "Check latency of the bot"
    let args: [Discord.DiscordApplicationCommandOption] = []
    let cog: Cog
    let client: DiscordClient
    
    init(cog: Cog) {
        self.cog = cog
        self.client = cog.bot
    }
    
    func invoke_interaction(interaction: Discord.DiscordInteraction) async {
        client.createInteractionResponse(for: interaction.id, token: interaction.token, response: .init(type: .deferredChannelMessageWithSource)) { data, httpresponse in
            
        }
        client.editMessage(interaction.message!.id, on: interaction.channelId, edit: .init(content: "Pong!"))
    }
    
    func invoke(_ name: Any) {
        <#code#>
    }
}
