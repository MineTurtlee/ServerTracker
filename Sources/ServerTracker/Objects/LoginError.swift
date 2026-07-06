//
//  File.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 6/7/26.
//

import Foundation

public struct LoginError: Codable {
    enum CodingKeys {
        case error = "message"
        case code
    }
    
    var error: String
    var code: Int = 0
}
