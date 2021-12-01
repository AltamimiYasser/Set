//
//  SetGame.swift
//  Set
//
//  Created by Yasser Tamimi on 29/11/2021.
//

import Foundation
import SwiftUI

struct SetGame {
    var cards = [Card]()
    var dealtCards: [Card] { cards.filter { $0.isDealt && !$0.isIncludedInASet }}
    var selectedCards: [Card] { cards.filter { $0.isSelected }}

    init() {
        cards = generateCards()
        dealCards(isFirstTime: true)
    }

    private func generateCards() -> [Card] {
        var allCards: [Card] = []
        for cardShape in Card.CardShape.allCases {
            for cardColor in Card.CardColor.allCases {
                for cardNumber in Card.CardNumber.allCases {
                    for cardShading in Card.CardShading.allCases {
                        allCards.append(Card(shape: cardShape, color: cardColor, number: cardNumber, shading: cardShading))
                    }
                }
            }
        }
        return allCards.shuffled()
    }

    mutating func select(_ card: Card) {
        guard selectedCards.count < 3 else {
            deselectAll()
            select(card)
            return
        }

        if let indexOfCard = cards.firstIndex(of: card) {
            guard !cards[indexOfCard].isIncludedInASet else { return }
            cards[indexOfCard].isSelected = true

            if selectedCards.count == 3 {
                if isASet(selectedCards) {
                    includeCardInSet()
                    dealThreeCards()
                } else {
                    deselectAll()
                }
            }
        }
    }

    mutating func deselect(_ card: Card) {
        if let index = cards.firstIndex(of: card) {
            guard selectedCards.count < 3 else { return }
            cards[index].isSelected = false
        }
    }

    mutating func deselectAll() {
        for (i, _) in cards.enumerated() {
            cards[i].isSelected = false
        }
    }

    mutating func dealCards(isFirstTime: Bool = false) {
        if isFirstTime {
            dealCardsFirstTime()
        } else {
            dealThreeCards()
        }
    }

    private mutating func dealCardsFirstTime() {
        for _ in 0 ..< 12 {
            let availableCards = getAvailableCardsToDeal()
            setDealtCard(availableCards)
        }
    }

    private mutating func dealThreeCards() {
        var availableCards = getAvailableCardsToDeal()
        if availableCards.count < 3 {
            for _ in availableCards {
                availableCards = getAvailableCardsToDeal()
                setDealtCard(availableCards)
            }
        } else {
            for _ in 0 ..< 3 {
                let availableCards = getAvailableCardsToDeal()
                guard availableCards.count >= 3 else { return }
                setDealtCard(availableCards)
            }
        }
    }

    private mutating func setDealtCard(_ availableCards: [SetGame.Card]) {
        let card = availableCards.randomElement()!
        if let index = cards.firstIndex(of: card) {
            cards[index].isDealt = true
        }
    }

    func getAvailableCardsToDeal() -> [Card] {
        cards.filter { !$0.isDealt && !$0.isIncludedInASet }
    }

    private func isASet(_ passedCards: [Card]) -> Bool {
        var result = true
        // set will help remove repeated items
        let shapes = Set(passedCards.map { $0.shape })
        if shapes.count == 2 { result = false }

        let colors = Set(passedCards.map { $0.color })
        if colors.count == 2 { result = false }

        let numbers = Set(passedCards.map { $0.number })
        if numbers.count == 2 { result = false }

        let shadings = Set(passedCards.map { $0.shading })
        if shadings.count == 2 { result = false }

        return result
    }

    private mutating func includeCardInSet() {
        selectedCards.forEach { card in
            if let index = cards.firstIndex(of: card) {
                cards[index].isIncludedInASet = true
            }
        }
    }

    struct Card: Equatable, Identifiable {
        let id = UUID()

        let shape: CardShape
        let color: CardColor
        let number: CardNumber
        let shading: CardShading

        var isSelected = false
        var isIncludedInASet = false
        var isDealt = false

        static func == (lhs: Card, rhs: Card) -> Bool {
            return
                lhs.shape == rhs.shape &&
                lhs.color == rhs.color &&
                lhs.number == rhs.number &&
                lhs.shading == rhs.shading
        }

        enum CardShape: CaseIterable {
            case diamond, oval, squiggle
        }

        enum CardColor: CaseIterable {
            case red, green, purple
        }

        enum CardNumber: CaseIterable {
            case one, two, three
        }

        enum CardShading: CaseIterable {
            case solid, stripped, open
        }
    }
}
