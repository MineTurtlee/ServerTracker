//
//  File.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 10/7/26.
//

import Foundation
import Discord

extension TrackerBot {
    func sync() {
        var cogs: [any Cog]!
        Task {
            cogs = await cogManager?.allCogs()
        }
        
        for cog in cogs {
            var commands: [Command]
            Task {
                commands = await cog.commands
            }
            for command in commands {
                bot.createApplicationCommand(name: command.name, description: command.description, options: command.args) { data, httpres in
                    
                }
            }
        }
    }
}
