//
//  Concentration.swift
//  Concentration
//
//  Created by John Martin on 11/12/17.
//  Copyright © 2017 John Martin. All rights reserved.
//

import Foundation
import GameKit

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get { return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { for index in cards.indices { cards[index].isFaceUp = index == newValue } }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards array.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] { cards[matchIndex].isMatched = true; cards[index].isMatched = true }
                cards[index].isFaceUp = true
            } else { indexOfOneAndOnlyOneFaceUpCard = index }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards.")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
    }
}
extension Collection {
    var oneAndOnly: Element? { return count == 1 ? first : nil }
}

struct Card: Hashable {
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool { return lhs.identifier == rhs.identifier }
    
    var isFaceUp = false
    var isMatched = false
    
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){ self.identifier = Card.getUniqueIdentifier() }
}
