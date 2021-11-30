//
//  SquigglesView.swift
//  Set
//
//  Created by Yasser Tamimi on 30/11/2021.
//

import SwiftUI

struct SquigglesView: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            let minX = rect.minX
            let midX = rect.midX
            let maxX = rect.maxX

            let minY = rect.minY
            let maxY = rect.maxY

            let width = rect.width
            let height = rect.height

            p.move(to: CGPoint(x: width * 0.85, y: minY))
            p.addCurve(
                to: CGPoint(x: width * 0.80, y: height * 0.90),
                control1: CGPoint(x: width * 1.10, y: minY),
                control2: CGPoint(x: maxX, y: height * 0.80)
            )

            p.addCurve(
                to: CGPoint(x: width * 0.35, y: height * 0.80),
                control1: CGPoint(x: width * 0.60, y: maxY),
                control2: CGPoint(x: midX, y: height * 0.80)
            )

            p.addCurve(
                to: CGPoint(x: width * 0.10, y: maxY),
                control1: CGPoint(x: width * 0.25, y: height * 0.80),
                control2: CGPoint(x: width * 0.20, y: maxY)
            )

            p.addCurve(
                to: CGPoint(x: width * 0.12, y: height * 0.12),
                control1: CGPoint(x: width * -0.10, y: height * 0.90),
                control2: CGPoint(x: minX, y: height * 0.3)
            )

            p.addCurve(
                to: CGPoint(x: width * 0.66, y: height * 0.20),
                control1: CGPoint(x: width * 0.3, y: height * -0.20),
                control2: CGPoint(x: midX, y: height * 0.20)
            )

            p.addCurve(
                to: CGPoint(x: width * 0.85, y: minY),
                control1: CGPoint(x: width * 0.75, y: height * 0.20),
                control2: CGPoint(x: width * 0.80, y: minY)
            )

            p.closeSubpath()

        }
    }
}
