//
//  Config.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 19/6/26.
//

import Foundation

struct Config: Codable {
    enum CodingKeys: String, CodingKey {
        case hash = "password"
        case token
        case prefix
    }
    
    var hash: String
    var token: String
    var prefix: String
}
