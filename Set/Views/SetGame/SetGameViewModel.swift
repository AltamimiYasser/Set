//
//  SetGameViewModel.swift
//  Set
//
//  Created by Yasser Tamimi on 30/11/2021.
//

import Foundation

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    @Published private var model = SetGame()
    
    var dealtCards: [Card] { model.dealtCards }
    var selectedCard: [Card] { model.selectedCards }
    
    // MARK: - User Intent(s)
    func select(_ card: Card) {
        model.select(card)
    }
    
    func deselect(_ card: Card) {
        model.deselect(card)
    }
    
    func deal() {
        model.dealCards()
    }
}
