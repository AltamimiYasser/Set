//
//  SetGameViewModel.swift
//  Set
//
//  Created by Yasser Tamimi on 30/11/2021.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    @Published private var model = SetGame()

    var dealtCards: [Card] { model.dealtCards }

    var selectedCard: [Card] { model.selectedCards }
    var availableCard: [Card] { model.getAvailableCardsToDeal() }

    // MARK: - User Intent(s)

    func selectCardAndReturnIfIsASet(_ card: Card) -> Bool {
        model.select(card)
        if let index = model.cards.firstIndex(of: card) {
            return model.cards[index].isIncludedInASet
        } else {
            return false
        }
    }

    func newGame() {
        model = SetGame()
    }

    func deselect(_ card: Card) {
        model.deselect(card)
    }

    func deal(firstTime: Bool) {
        model.dealCards(isFirstTime: firstTime)
    }

    @ViewBuilder
    static func getShapeForCard(_ card: SetGame.Card) -> some View {
        switch card.shape {
        case .diamond:
            if card.shading == .open {
                DimondView().stroke(lineWidth: 3)
            } else {
                DimondView()
            }
        case .oval:
            if card.shading == .open {
                RoundedRectangle(cornerRadius: 50).stroke(lineWidth: 3)
            } else {
                RoundedRectangle(cornerRadius: 50)
            }
        case .squiggle:
            if card.shading == .open {
                SquigglesView().stroke(lineWidth: 3)
            } else {
                SquigglesView()
            }
        }
    }

    static func getColorForCard(_ card: SetGame.Card) -> Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }

    static func getShadingForCard(_ card: SetGame.Card, withColor color: Color) -> Color {
        switch card.shading {
        case .open:
            return Color.clear
        case .solid:
            return color
        case .stripped:
            return color.opacity(0.5)
        }
    }

    static func getNumberForCard(_ card: SetGame.Card) -> Int {
        switch card.number {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        }
    }
}
