//
//  LoadCogs.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 9/7/26.
//

import Foundation
@preconcurrency import Discord

extension TrackerBot {
    static let allCogs: [Cog.Type] = [
        PingPong.self
    ]
    
    func loadCogs() {
        let manager = cogManager
        let cogs = Self.allCogs
        Task {
            for cog in cogs {
                await manager?.load(cog: cog)
            }
        }
    }
}
