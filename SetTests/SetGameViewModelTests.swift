//
//  SetGameViewModelTests.swift
//  SetTests
//
//  Created by Yasser Tamimi on 30/11/2021.
//

import XCTest

class SetGameViewModelTests: XCTestCase {
    typealias Card = SetGame.Card

    var vm: SetGameViewModel!
    var cards: [Card]!

    override func setUp() {
        vm = SetGameViewModel()
        cards = [
            Card(shape: .diamond, color: .red, number: .two, shading: .solid),
            Card(shape: .oval, color: .purple, number: .three, shading: .open),
            Card(shape: .squiggle, color: .green, number: .one, shading: .stripped),
        ]
    }

    func test_vmInitializedWithModelHas12DealtCards() {
        let dealtCardsCount = vm.dealtCards.count
        XCTAssertEqual(dealtCardsCount, 12)
    }
    
    func test_select_shouldSelectTheCorrectCard() {
        vm.select(cards[0])
        XCTAssertEqual(cards[0], vm.selectedCard[0])
    }
    
    func test_selectedCard_shouldGiveTheSelectedCard() {
        vm.select(cards[0])
        XCTAssertEqual(vm.selectedCard.count, 1)
        vm.select(cards[1])
        XCTAssertEqual(vm.selectedCard.count, 2)
    }
    
    func test_deselectCard_shouldDeselectGivenCard() {
        vm.select(cards[0])
        vm.deselect(cards[0])
        XCTAssertFalse(vm.selectedCard.contains(cards[0]))
    }
    
    func test_deal_shouldDeal3NewCards() {
        let dealtCardsCount = vm.dealtCards.count
        vm.deal()
        XCTAssertEqual(vm.dealtCards.count, dealtCardsCount + 3)
    }
    
    func test_deal_shouldStopDealingAfter82Cards() {
        for _ in 0..<30 {
            vm.deal()
        }
        XCTAssertEqual(vm.dealtCards.count, 81)
    }
}
