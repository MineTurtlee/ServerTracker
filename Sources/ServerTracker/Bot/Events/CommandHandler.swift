//
//  File.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 6/7/26.
//

import Foundation
import Discord

extension TrackerBot {
    func client(_ client: DiscordClient, didCreateMessage message: DiscordMessage) {
        if message.content?.starts(with: self.prefix) == true {
            // MARK: NOT IMPLEMENTED
            // TODO: DO THIS LATER
        }
    }
    
    func client(_ client: DiscordClient, didCreateInteraction interaction: DiscordInteraction) {
        // basically command handling...?
    }
}
