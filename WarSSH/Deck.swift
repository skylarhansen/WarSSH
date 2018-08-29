//
//  Deck.swift
//  WarSSH
//
//  Created by Skylar Hansen on 8/24/18.
//  Copyright © 2018 Skylar Hansen. All rights reserved.
//

import Foundation

struct Deck: Codable {
    let deckID: String
    let cards: [Card]?

    enum CodingKeys: String, CodingKey {
        case deckID = "deck_id"
        case cards
    }
}
