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
        vm.deal(firstTime: true)
        let dealtCardsCount = vm.dealtCards.count
        print("Dealt Cards Count in VM: \(dealtCardsCount)")
        XCTAssertEqual(dealtCardsCount, 12)
    }

    func test_select_shouldSelectTheCorrectCard() {
        _ = vm.selectCardAndReturnIfIsASet(cards[0])
        XCTAssertEqual(cards[0], vm.selectedCard[0])
    }

    func test_selectedCard_shouldGiveTheSelectedCard() {
        _ = vm.selectCardAndReturnIfIsASet(cards[0])
        XCTAssertEqual(vm.selectedCard.count, 1)
        _ = vm.selectCardAndReturnIfIsASet(cards[1])
        XCTAssertEqual(vm.selectedCard.count, 2)
    }

    func test_deselectCard_shouldDeselectGivenCard() {
        _ = vm.selectCardAndReturnIfIsASet(cards[0])
        vm.deselect(cards[0])
        XCTAssertFalse(vm.selectedCard.contains(cards[0]))
    }

    func test_deal_shouldDeal3NewCards() {
        let dealtCardsCount = vm.dealtCards.count
        vm.deal(firstTime: false)
        XCTAssertEqual(vm.dealtCards.count, dealtCardsCount + 3)
    }

    func test_deal_shouldStopDealingAfter82Cards() {
        vm.deal(firstTime: true)
        for _ in 0 ..< 30 {
            vm.deal(firstTime: false)
        }
        XCTAssertEqual(vm.dealtCards.count, 81)
    }
}
