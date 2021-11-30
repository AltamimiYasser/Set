//
//  SetGameTests.swift
//  SetTests
//
//  Created by Yasser Tamimi on 29/11/2021.
//

import XCTest

class SetGameTests: XCTestCase {
    typealias Card = SetGame.Card

    var setGame: SetGame!

    override func setUp() {
        super.setUp()
        setGame = SetGame()
    }

    func test_setGameInit_with81Cards() {
        let cards = setGame.cards

        XCTAssertEqual(cards.count, 81)
    }

    func test_setGameInit_withAllUniqueCards() {
        let cards = setGame.cards

        var allUniqueElements = true
        for (i, outerCard) in cards.enumerated() {
            for (j, innerCard) in cards.enumerated() {
                if i == j { continue }
                if outerCard == innerCard { allUniqueElements = false }
            }
        }

        XCTAssertTrue(allUniqueElements)
    }

    func test_chooseCard_shouldChooseTheCorrectCard() {
        let card = Card(shape: .oval, color: .green, number: .one, shading: .open)

        setGame.select(card)
        if let index = setGame.cards.firstIndex(of: card) {
            XCTAssertTrue(setGame.cards[index].isSelected)
        }
    }

    func test_selectedCardIsAddedToSelectedCardsArray() {
        let card = Card(shape: .oval, color: .green, number: .one, shading: .open)

        setGame.select(card)

        XCTAssertTrue(setGame.selectedCards.contains(card))
    }

    func test_selectedCardShouldNotBeMoreThan3() {
        let card1 = Card(shape: .oval, color: .green, number: .one, shading: .open)
        let card2 = Card(shape: .diamond, color: .purple, number: .two, shading: .open)
        let card3 = Card(shape: .squiggle, color: .purple, number: .three, shading: .stripped)
        let card4 = Card(shape: .squiggle, color: .purple, number: .three, shading: .solid)
        setGame.select(card1)
        setGame.select(card2)
        setGame.select(card3)
        setGame.select(card4)

        XCTAssertEqual(setGame.selectedCards.count, 3)
    }

    func test_deselectCard_shouldDeselectCard() {
        setUp()
        let card = Card(shape: .diamond, color: .red, number: .two, shading: .solid)
        setGame.select(card)
        setGame.deselect(card)
        let selectedCardIndex = setGame.cards.firstIndex(of: card)!
        let selectedCard = setGame.cards[selectedCardIndex]
        XCTAssertFalse(selectedCard.isSelected)
        
    }

    func test_deselectCards_shouldPutAllCardsToDeselectMode() {
        setGame.deselectAll()

        let allDeselected = setGame.cards.allSatisfy { !$0.isSelected }
        XCTAssertTrue(allDeselected)
    }

    func test_selectCard_shouldChangeCardIcludedInSetToTrueIfIncludedInSetAndFalseOtherWise() {
        // set (all same except only shape is different in each one of them)
        setUp()
        let setShapeCards = [
            Card(shape: .diamond, color: .purple, number: .three, shading: .stripped),
            Card(shape: .squiggle, color: .purple, number: .three, shading: .stripped),
            Card(shape: .oval, color: .purple, number: .three, shading: .stripped),
        ]
        setGame.select(setShapeCards[0])
        setGame.select(setShapeCards[1])
        setGame.select(setShapeCards[2])

        let filteredToSetShape = setGame.selectedCards.filter { $0.isIncludedInASet }
        var allInASet = filteredToSetShape.count == 3

        XCTAssertTrue(allInASet)

        // not set (all same except shape is same in 2 cards but different in third with one other item modified so we don't select same card twice)
        setUp()
        let notSetShapeCards = [
            Card(shape: .diamond, color: .purple, number: .three, shading: .stripped),
            Card(shape: .diamond, color: .purple, number: .three, shading: .open),
            Card(shape: .oval, color: .purple, number: .three, shading: .solid),
        ]

        setGame.select(notSetShapeCards[0])
        setGame.select(notSetShapeCards[1])
        setGame.select(notSetShapeCards[2])

        let filteredToNotSetShape = setGame.selectedCards.filter { $0.isIncludedInASet }
        allInASet = filteredToNotSetShape.count == 3

        XCTAssertFalse(allInASet)

        // set (all same except only color is different in each one of them)
        setUp()
        let setColorsCards = [
            Card(shape: .diamond, color: .purple, number: .three, shading: .stripped),
            Card(shape: .diamond, color: .green, number: .three, shading: .stripped),
            Card(shape: .diamond, color: .red, number: .three, shading: .stripped),
        ]
        setGame.select(setColorsCards[0])
        setGame.select(setColorsCards[1])
        setGame.select(setColorsCards[2])

        let filteredToSetColor = setGame.selectedCards.filter { $0.isIncludedInASet }
        allInASet = filteredToSetColor.count == 3

        XCTAssertTrue(allInASet)

        // not set (all same except color is same in 2 cards but different in third)
        setUp()
        let notSetColorsCards = [
            Card(shape: .diamond, color: .purple, number: .three, shading: .stripped),
            Card(shape: .diamond, color: .purple, number: .three, shading: .open),
            Card(shape: .diamond, color: .red, number: .three, shading: .solid),
        ]

        setGame.select(notSetColorsCards[0])
        setGame.select(notSetColorsCards[1])
        setGame.select(notSetColorsCards[2])

        let filteredToNotSetColor = setGame.selectedCards.filter { $0.isIncludedInASet }
        allInASet = filteredToNotSetColor.count == 3

        XCTAssertFalse(allInASet)

        // set (all same except only number is different in each one of them)
        setUp()
        let setNumbersCards = [
            Card(shape: .diamond, color: .purple, number: .one, shading: .stripped),
            Card(shape: .diamond, color: .purple, number: .two, shading: .stripped),
            Card(shape: .diamond, color: .purple, number: .three, shading: .stripped),
        ]
        setGame.select(setNumbersCards[0])
        setGame.select(setNumbersCards[1])
        setGame.select(setNumbersCards[2])

        let filteredToSetNumber = setGame.selectedCards.filter { $0.isIncludedInASet }
        allInASet = filteredToSetNumber.count == 3

        XCTAssertTrue(allInASet)

        // not set (all same except number is same in 2 cards but different in third)setGame.deselectAll()
        setGame.deselectAll()
        let notSetNumbersCards = [
            Card(shape: .diamond, color: .purple, number: .three, shading: .stripped),
            Card(shape: .diamond, color: .purple, number: .three, shading: .open),
            Card(shape: .diamond, color: .purple, number: .one, shading: .solid),
        ]

        setGame.select(notSetNumbersCards[0])
        setGame.select(notSetNumbersCards[1])
        setGame.select(notSetNumbersCards[2])

        let filteredToNotSetNumber = setGame.selectedCards.filter { $0.isIncludedInASet }
        allInASet = filteredToNotSetNumber.count == 3

        XCTAssertFalse(allInASet)

        // set (all same except only shading is different in each one of them)
        setUp()
        let setShadingsCards = [
            Card(shape: .diamond, color: .purple, number: .one, shading: .stripped),
            Card(shape: .diamond, color: .purple, number: .one, shading: .solid),
            Card(shape: .diamond, color: .purple, number: .one, shading: .open),
        ]
        setGame.select(setShadingsCards[0])
        setGame.select(setShadingsCards[1])
        setGame.select(setShadingsCards[2])

        let filteredToSetShading = setGame.selectedCards.filter { $0.isIncludedInASet }
        allInASet = filteredToSetShading.count == 3

        XCTAssertTrue(allInASet)

        // not set (all same except shading is same in 2 cards but different in third)
        setUp()
        let notSetShadingsCards = [
            Card(shape: .oval, color: .purple, number: .three, shading: .stripped),
            Card(shape: .diamond, color: .purple, number: .three, shading: .open),
            Card(shape: .squiggle, color: .purple, number: .three, shading: .open),
        ]

        setGame.select(notSetShadingsCards[0])
        setGame.select(notSetShadingsCards[1])
        setGame.select(notSetShadingsCards[2])

        let filteredToNotSetShading = setGame.selectedCards.filter { $0.isIncludedInASet }
        allInASet = filteredToNotSetShading.count == 3

        XCTAssertFalse(allInASet)
    }

    func test_cardIncludedInASetCannotBeChosenAgain() {
        setUp()
        let setShapeCards = [
            Card(shape: .diamond, color: .purple, number: .three, shading: .stripped),
            Card(shape: .squiggle, color: .purple, number: .three, shading: .stripped),
            Card(shape: .oval, color: .purple, number: .three, shading: .stripped),
        ]
        setGame.select(setShapeCards[0])
        setGame.select(setShapeCards[1])
        setGame.select(setShapeCards[2])

        setGame.deselectAll()

        setGame.select(setShapeCards[0])
        XCTAssertEqual(setGame.selectedCards.count, 0)
    }

    func test_gameInit_shouldDeal12CardsOnTheTable() {
        setUp()
        XCTAssertEqual(setGame.dealtCards.count, 12)
    }

    func test_dealThreeCards_shouldAddThreeCardsToTheTable() {
        setUp()
        setGame.dealCards()
        XCTAssertEqual(setGame.dealtCards.count, 12 + 3)
    }
    
    func test_deal_shouldStopDealingAfter82CardsAreDealt() {
        for _ in 0..<30 {
            setGame.dealCards()
        }
        XCTAssertEqual(setGame.dealtCards.count, 81)
    }

}
