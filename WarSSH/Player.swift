//
//  Player.swift
//  WarSSH
//
//  Created by Skylar Hansen on 8/24/18.
//  Copyright © 2018 Skylar Hansen. All rights reserved.
//

import Foundation

class Player {
    var cards: [Card]
    var playedCard: Card?
    var playedCards: [Card] = []
    var warCards: [Card] = []

    init(cards: [Card]) {
        self.cards = cards
    }

    func moveNextCardToPlayed() {
        let card = cards.remove(at: 0)
        playedCards.insert(card, at: 0)
    }
}
