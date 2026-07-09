//
//  Presence.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 7/7/26.
//

import Foundation

struct Presence: Codable {
    enum CodingKeys: String, CodingKey {
        case enabled
        case type
        case name
        case details
        case state
        case large_image
        case small_image
        case start
        case end
        case party
    }
    
    var enabled: Bool = false
    var type: Int = 0
    var name: String = ""
    var details: String = ""
    var state: String = ""
    var large_image: Image = Image()
    var small_image: Image = Image()
    var start: Int64 = 0
    var end: Int64 = 0
    var party: Party = Party()
}

struct Image: Codable {
    enum CodingKeys: String, CodingKey {
        case key
        case description
    }
    
    var key: String = ""
    var description: String = ""
}

struct Party: Codable {
    enum CodingKeys: String, CodingKey {
        case current
        case max
    }
    
    var current: Int = 0
    var max: Int = 0
}
