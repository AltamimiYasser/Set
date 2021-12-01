//
//  CardView.swift
//  Set
//
//  Created by Yasser Tamimi on 01/12/2021.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var vm: SetGameViewModel
    var card: SetGame.Card
    var lineWidth: CGFloat { card.isSelected ? 5 : 2 }
    @Binding var correctAnswerColor: Color

    var body: some View {
        let shape = SetGameViewModel.getShapeForCard(card)
        let color = SetGameViewModel.getColorForCard(card)
        let number = SetGameViewModel.getNumberForCard(card)
        let shading = SetGameViewModel.getShadingForCard(card, withColor: color)

        ZStack {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: lineWidth)
                    .animation(.default, value: lineWidth)

                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ForEach(0 ..< number) { _ in
                            shape
                                .aspectRatio(3 / 2, contentMode: .fit)
                                .frame(height: geo.size.height * 0.25)
                                .foregroundColor(card.shading == .open ? color : shading)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }

        .onTapGesture {
            selectCard()
        }
    }

    private func selectCard() {
        if card.isSelected {
            vm.deselect(card)
        } else {
            if vm.selectedCard.count == 2 {
                let includedInASet = vm.selectCardAndReturnIfIsASet(card)
                if includedInASet {
                    blinkWithColor(.green)
                } else {
                    blinkWithColor(.red)
                }
            } else {
                _ = vm.selectCardAndReturnIfIsASet(card)
            }
        }
    }

    private func blinkWithColor(_ color: Color) {
        var toggle = true
        var timerCounter = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            toggle.toggle()
            correctAnswerColor = toggle ? .clear : color
            timerCounter += 1
            if timerCounter >= 3 {
                correctAnswerColor = .clear
                timer.invalidate()
            }
        }
    }
}

