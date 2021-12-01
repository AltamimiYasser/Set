//
//  SetGameView.swift
//  Set
//
//  Created by Yasser Tamimi on 29/11/2021.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var vm = SetGameViewModel()

    init() {
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75, maximum: 110))]) {
                    ForEach(vm.dealtCards) { card in
                        let shape = vm.getShapeForCard(card)
                        let color = vm.getColorForCard(card)
                        let number = vm.getNumberForCard(card)
                        let shading = vm.getShadingForCard(card, withColor: color)

                        ZStack {
                            GeometryReader { geo in
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(lineWidth: 2)
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        ForEach(0 ..< number) { _ in
                                            shape
                                                .aspectRatio(3 / 2, contentMode: .fit)
                                                .padding(3)
                                                .frame(height: geo.size.height * 0.25)
                                                .foregroundColor(card.shading == .open ? color : shading)
                                        }
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .aspectRatio(2 / 3, contentMode: .fit)
                        .foregroundColor(color)
                    }
                }
            }
            Button {
                vm.deal()
            } label: {
                Text("Deal Cards")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
