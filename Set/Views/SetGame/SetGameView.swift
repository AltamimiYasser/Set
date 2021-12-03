//
//  SetGameView.swift
//  Set
//
//  Created by Yasser Tamimi on 29/11/2021.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var vm = SetGameViewModel()
    @State var lineWidth: CGFloat = 2
    @State var borderColor = Color.clear
    @State var dealFirstTime = true

    init() {
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 110))]) {
                    ForEach(vm.dealtCards) { card in
                        let color = SetGameViewModel.getColorForCard(card)
                        CardView(vm: vm, card: card, correctAnswerColor: $borderColor)
                            .aspectRatio(2 / 3, contentMode: .fit)
                            .foregroundColor(color)
                    }
                    .animation(.default, value: vm.dealtCards)
                }
                .overlay(content: overlay)
            }
            downButton
        }
        .padding()
    }

    private func overlay() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(borderColor)
                .animation(.default, value: borderColor)
            Text(borderColor == .red ? "Wrong!" : "Correct!")
                .font(.system(size: 80))
                .foregroundColor(borderColor != .clear ? .white : .clear)
        }
    }

    private var downButton: some View {
        HStack {
            Button {
                if dealFirstTime {
                    vm.deal(firstTime: true)
                    dealFirstTime = false
                } else {
                    vm.deal(firstTime: false)
                }
            } label: {
                Text("Deal Cards")
            }
            .disabled(vm.availableCard.count == 0)
            .buttonStyle(.borderedProminent)
            Spacer()
            Button {
                vm.newGame()
                dealFirstTime = true
            } label: {
                Text("New Game")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
