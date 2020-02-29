//
//  Hand.swift
//  Blackjack
//
//  Created by abe on 2/25/20.
//  Copyright © 2020 thoughtbot. All rights reserved.
//

struct Hand {
    var deck_id: String?
    var cards: [Card] = []
    var score: Int {
        cards.map {$0.points}.reduce(0, +)
    }
}
