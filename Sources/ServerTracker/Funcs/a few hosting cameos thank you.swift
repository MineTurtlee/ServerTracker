//
//  File.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 6/7/26.
//

import Foundation

struct Wispbyte: Codable {
    enum CodingKeys: String, CodingKey {
        case url
        case discord
        case panels
    }
    
    // Majority asked for it so why not?
    var url = URL(string: "https://wispbyte.com")
    var discord = URL(string: "https://discord.gg/b25KfEFNmd")
    var panels = [
        URL(string: "https://wispbyte.com/client"),
        URL(string: "https://pro.wispbyte.com"),
        URL(string: "https://free.wispbyte.com"),
        // URL(string: "https://billing.wispbyte.com")
    ]
}

struct Nemea: Codable {
    enum CodingKeys: String, CodingKey {
        case websites
        case discord
        case panels
    }
    
    var websites = [
        URL(string: "https://nemea.uk"),
        URL(string: "https://v2.nemea.uk")
    ]
    var discord = URL(string: "https://discord.gg/y34NQshdFb")
    var panels = [
        URL(string: "https://panel.nemea.uk") // that's it?
    ]
}
