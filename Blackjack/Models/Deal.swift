//
//  Deal.swift
//  Blackjack
//
//  Created by abe on 2/25/20.
//  Copyright © 2020 thoughtbot. All rights reserved.
//

struct Deal: Codable, Hashable {
    let success: Bool
    let cards: [Card]?
    let deck_id: String
    let remaining: Int
}
