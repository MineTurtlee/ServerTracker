//
//  File.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 10/7/26.
//

import Foundation
import Discord
import Logging

fileprivate let logger = Logger(label: "TrackerBot")

extension TrackerBot {
    func sync() async {
        var cogs: [any Cog]!
        cogs = await cogManager?.allCogs()
        
        for cog in cogs {
            var commands: [Command]
            commands = await cog.commands
            
            for command in commands { // root command

                var opts: [DiscordApplicationCommandOption] = []
                if command.subcommands.count > 0 { // subcommand 1
                    
                    for subcommand in command.subcommands {
                        if subcommand.subcommands.count > 0 { // subcommand 2's subcommands (basically no a command cant have >2 levels deep)
                            logger.error("You can't add a third group!")
                            break
                        }
                        var choices: [DiscordApplicationCommandOptionChoice] = []
                        if subcommand.choices.count > 0 {
                            for (name, value) in subcommand.choices {
                                switch value {
                                    case .string(let stringValue):
                                        choices.append(DiscordApplicationCommandOptionChoice(name: name, value: .string(stringValue)))
                                    case .int(let intValue):
                                        choices.append(DiscordApplicationCommandOptionChoice(name: name, value: .int(intValue)))
                                    }
                            }
                        }
                        let opt = DiscordApplicationCommandOption(type: .subCommand, name: subcommand.name, description: subcommand.description, choices: choices, options: subcommand.args)
                        opts.append(opt)
                    }
                }
                
                bot.createApplicationCommand(name: command.name, description: command.description, options: command.args + opts) { data, httpres in
                    logger.info("Registered command \(command.name) with description \(command.description): \(httpres?.statusCode, default: "200")")
                }
            }
            
            bot.getApplicationCommands() { commandList, resp in
                for command in commandList {
                    var flagForSubcmds: Bool = false
                    
                    cName: for com in commands {
                        if com.name == command.name {
                            flagForSubcmds = true
                            break cName
                        }
                        oLoop1: for option in command.options! {
                            switch option.type {
                                // nice string literal is unused but its bad asf lmfaofamsfoamsofaomfso
                            case .subCommand:
                                if option.name == com.name {
                                    flagForSubcmds = true
                                    break oLoop1
                                }
                            case .subCommandGroup:
                                oLoop2: for subcmd in option.options! {
                                    switch subcmd.type {
                                        // nice string literal is unused but its bad asf lmfaofamsfoamsofaomfso
                                    case .subCommand:
                                        if subcmd.name == com.name {
                                            flagForSubcmds = true
                                            break oLoop2
                                        }
                                    case .subCommandGroup:
                                        logger.error("A THIRD SUBCMDGROUP ISNT SUPPORTED RAAHHHH (this is an edge case but discord wouldnt so)")
                                    default: continue
                                    }
                                }
                            default: continue
                            }
                        }
                    }
                        
                    if flagForSubcmds == true {} else {
                        logger.warning("Deleting command \(command.name) with ID \(command.id)")
                        self.bot.deleteApplicationCommand(command.id)
                    }
                }
            }
        }
    }
}
// placeholder for Xcode to add a 100th line YAAYYYYY ^w^
