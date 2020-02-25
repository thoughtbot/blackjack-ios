//
//  Card.swift
//  Blackjack
//
//  Created by abe on 2/25/20.
//  Copyright © 2020 thoughtbot. All rights reserved.
//
import Foundation

struct Card: Codable, Hashable {
    let identifier = UUID()
    let image: String
    let value: String
    let suit: String
    var points: Int {
        Int(value) ?? 10
    }
    
    private enum CodingKeys : String, CodingKey {
        case image, value, suit
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
