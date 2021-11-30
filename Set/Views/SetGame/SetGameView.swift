//
//  SetGameView.swift
//  Set
//
//  Created by Yasser Tamimi on 29/11/2021.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var vm = SetGameViewModel()

    var body: some View {
        VStack {
            AspectVGrid(items: vm.dealtCards, aspectRatio: 2 / 3) { card in
                CardView(card: card)
                    .padding(5)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: SetGame.Card

    var shape: some View { getShapeForCard(card) }
    var color: Color { getColorForCard(card) }
    var shade: Color { getShadingForCard(card, withColor: color) }
    var number: Int { getNumberForCard(card) }

    var body: some View {
        let shape = shape
            .aspectRatio(3 / 2, contentMode: .fit)
            .padding(.vertical, 10)

        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 3)
                HStack {
                    Spacer()
                    VStack {
                        ForEach(0 ..< number) { _ in
                            if card.shading == .open {
                                shape
                                    .frame(height: geo.size.height / 3 * 0.90)
                            } else {
                                shape
                                    .foregroundColor(shade)
                                    .frame(height: geo.size.height / 3 * 0.90)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .aspectRatio(2 / 3, contentMode: .fit)
            .foregroundColor(color)
        }
    }

    @ViewBuilder
    private func getShapeForCard(_ card: SetGame.Card) -> some View {
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

    private func getColorForCard(_ card: SetGame.Card) -> Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }

    private func getShadingForCard(_ card: SetGame.Card, withColor color: Color) -> Color {
        switch card.shading {
        case .open:
            return Color.clear
        case .solid:
            return color
        case .stripped:
            return color.opacity(0.5)
        }
    }

    private func getNumberForCard(_ card: SetGame.Card) -> Int {
        switch card.number {
        case .one: return 1
        case .two: return 2
        case .three: return 3
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
