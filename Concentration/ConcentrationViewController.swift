//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by John Martin on 11/12/17.
//  Copyright © 2017 John Martin. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int { return (cardButtons.count + 1)/2 }
    
    private(set) var flipCount = 0 {
        didSet {
            let attributes: [NSAttributedStringKey:Any] = [
                .strokeWidth: 5.0,
                .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) // UIColor.orange
            ]
            let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
            flipCountLabel.attributedText = attributedString
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            flipCount = 0
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton){
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons array.")
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        resetGame()
    }
    
    func resetGame() {
        flipCount = 0
//        emoji = [:]
//        emojiChoices = halloweenEmojiChoices
        for button in cardButtons {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) // UIColor.orange
            button.isEnabled = true
        }
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        theme = savedTheme
    }
    
    private func updateViewFromModel() {
        guard let _ = cardButtons else { return }
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.001043450342) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) // .clear : .orange
                button.isEnabled = !card.isMatched
            }
        }
    }
    var savedTheme: String?
    var theme: String? {
        didSet {
            savedTheme = theme
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    private let halloweenEmojiChoices = "🎃👻☠️👹🦇👺🍎🍭🙀🍬😱😈🤡🤖💀🕷🕸👽"
    
    private lazy var emojiChoices = halloweenEmojiChoices
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) ->String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = String(emojiChoices.remove(at: emojiChoices.randomStringIndex))
        }
        return emoji[card, default: "?"] // same as emoji[card] ?? "?"
    }
}

extension String {
    var randomStringIndex: String.Index {
        return self.index(self.startIndex, offsetBy: self.count.arc4random)
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else { return 0 }
    }
}




