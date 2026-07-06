//
//  Disconnected.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 21/6/26.
//

import Foundation
import Discord
import Logging

fileprivate let logger = Logger(label: "TrackerBot")

extension TrackerBot {
    func client(_ bot: DiscordClient, shouldAttemptResuming reason: DiscordGatewayCloseReason, closed: Bool) {
        switch reason {
        case .alreadyAuthenticated: return
        case .authenticationFailed: return logger.error("Authentication failed due to improper token or sum, is the token valid?")
        case .notAuthenticated: return logger.error("User is not authenticated, are you sure the token is valid?")
        case .disconnected: break
        case .goingAway: return logger.warning("The endpoint is going away")
        case .invalidSequence: break
        case .invalidShard: logger.warning("Oops, shard is invalid, let's try to reconnect"); break
        case .noNetwork: return logger.error("Connection dropped, check your Internet")
        case .normal: break
        case .rateLimited: return logger.error("User is ratelimited, try again later.")
        case .sessionTimeout: logger.warning("Our connection timed out, reconnecting"); break
        case .unknown: return
        case .unknownEncryptionMode: logger.error("Encryption mode unknown, retrying"); break
        case .unknownError: return
        case .unknownOpcode: logger.warning("Unknown opcode, retrying"); break
        case .unknownProtocol: return
        case .voiceServerCrash: return logger.warning("Oops, voice server crashed lolz")
        default: break
        }
        
        bot.connect()
    }
}
