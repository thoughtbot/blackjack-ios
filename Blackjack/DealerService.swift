//
//  DealerService.swift
//  Blackjack
//
//  Created by abe on 2/25/20.
//  Copyright © 2020 thoughtbot. All rights reserved.
//

import Combine
import Foundation

class DealerService {
    static func dealFromNewDeck() -> AnyPublisher<Deal, Error>{
        let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Deal.self, decoder: JSONDecoder())
            .flatMap({
                return self.dealFromDeck(with: $0.deck_id)
            }).eraseToAnyPublisher()
    }
    
    static func dealFromDeck(with id: String) -> AnyPublisher<Deal, Error> {
        let url = URL(string: "https://deckofcardsapi.com/api/deck/\(id)/draw/?count=1")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map(\.data)
            .decode(type: Deal.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
