//
//  Card.swift
//  WarSSH
//
//  Created by Skylar Hansen on 8/24/18.
//  Copyright © 2018 Skylar Hansen. All rights reserved.
//

import UIKit

struct Card: Codable, Equatable {
    let imageString: String
    let value: String
    let suit: String
    let code: String

    enum CodingKeys: String, CodingKey {
        case imageString = "image"
        case value
        case suit
        case code
    }

    var image: UIImage {
        guard let imgURL = URL(string: imageString),
            let data = try? Data(contentsOf: imgURL),
            let img = UIImage(data: data) else { return UIImage() }
        return img
    }

    var numericalValue: Int {
        if let int = Int(value) {
            return int
        } else {
            return numericalValue(forCardValue: value)
        }
    }

    private func numericalValue(forCardValue value: String) -> Int {
        switch value {
        case "JACK": return 11
        case "QUEEN": return 12
        case "KING": return 13
        case "ACE": return 14
        default: return 0
        }
    }
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.value == rhs.value
}
