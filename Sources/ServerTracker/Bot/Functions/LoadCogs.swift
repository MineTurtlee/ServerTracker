//
//  LoadCogs.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 9/7/26.
//

import Foundation
@preconcurrency import Discord

extension TrackerBot {
    func loadCogs() {
        Task {
            await cogManager?.load(cog: <#T##any Cog.Type#>)
        }
    }
}
