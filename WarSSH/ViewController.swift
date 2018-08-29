//
//  ViewController.swift
//  WarSSH
//
//  Created by Skylar Hansen on 8/24/18.
//  Copyright © 2018 Skylar Hansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var computerCardImageView: UIImageView!
    @IBOutlet weak var userCardImageView: UIImageView!
    @IBOutlet weak var winLabel: UILabel!

    var user: Player?
    var computer: Player?
    var gameState: GameState = .regular
    var warCount = 0

    enum GameState {
        case regular
        case war
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        GameController.shared.newShuffledDeck { (deck) in
            GameController.shared.draw(count: 52, fromDeck: deck, completion: { (cards) in
                let userCards = Array(cards.prefix(26))
                let compCards = Array(cards.suffix(26))
                self.user = Player(cards: userCards)
                self.computer = Player(cards: compCards)
            })
        }
    }

    // MARK: - Private

    private func playRegular() {
        guard let user = user,
            let computer = computer,
            let userCard = user.playedCards.first,
            let compCard = computer.playedCards.first else { return }

        var winner: Player
        var loser: Player

        if userCard.numericalValue > compCard.numericalValue {
            winner = user
            loser = computer
        } else {
            winner = computer
            loser = user
        }

        winner.cards.append(contentsOf: winner.playedCards)
        winner.cards.append(contentsOf: loser.playedCards)
        winner.playedCards.removeAll()
        loser.playedCards.removeAll()
    }

    private func playWar() {
        warCount += 1
        userCardImageView.image = #imageLiteral(resourceName: "dodgers-logo")
        computerCardImageView.image = #imageLiteral(resourceName: "dodgers-logo")
        if warCount % 3 == 0 {
            gameState = .regular
            warCount = 0
        }
    }

    // MARK: - Actions

    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let user = user,
            let comp = computer else { return }

        user.moveNextCardToPlayed()
        comp.moveNextCardToPlayed()

        switch gameState {
        case .regular:
            let userCard = user.playedCards.first
            let compCard = comp.playedCards.first
            userCardImageView.image = userCard?.image
            computerCardImageView.image = compCard?.image
            if userCard?.value == compCard?.value {
                gameState = .war
            } else {
                playRegular()
            }
        case .war:
            playWar()
        }
    }
}
