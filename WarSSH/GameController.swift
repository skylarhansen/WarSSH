//
//  GameController.swift
//  WarSSH
//
//  Created by Skylar Hansen on 8/24/18.
//  Copyright © 2018 Skylar Hansen. All rights reserved.
//

import Foundation

class GameController {

    static let shared = GameController()
    private let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/")

    func newShuffledDeck(completion: @escaping (Deck) -> Void) {
        guard let url = URL(string: "new/shuffle/?deck_count=1", relativeTo: baseURL) else {
            print("Unable to initialize url: \(baseURL!.absoluteString)new/shuffle/?deck_count=1")
            return
        }

        NetworkController.performRequest(forURL: url, httpMethod: .get) { (data, error) in
            guard error == nil, let data = data else {
                if let error = error {
                    print("Error performing request for url: \(url.absoluteString). ERROR: \(error.localizedDescription)")
                }
                return
            }

            if let deck = try? JSONDecoder().decode(Deck.self, from: data) {
                completion(deck)
            } else {
                print("Unable to decode from \(data)")
            }
        }
    }

    func draw(count: Int, fromDeck deck: Deck, completion: @escaping ([Card]) -> Void) {
        guard let url = URL(string: "\(deck.deckID)/draw/?count=\(count)", relativeTo: baseURL) else {
            print("Unable to initialize url: \(baseURL!.absoluteString)\(deck.deckID)/draw/?count=\(count)")
            return
        }

        NetworkController.performRequest(forURL: url, httpMethod: .get) { (data, error) in
            guard error == nil, let data = data else {
                if let error = error {
                    print("Error performing request for url: \(url.absoluteString). ERROR: \(error.localizedDescription)")
                }
                return
            }

            if let deck = try? JSONDecoder().decode(Deck.self, from: data),
                let cards = deck.cards {
                completion(cards)
            } else {
                print("Unable to decode from \(data)")
            }
        }
    }
}
