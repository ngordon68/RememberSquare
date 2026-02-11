//
//  ControlsSectionView.swift
//  RememberSquare
//
//  Created by Nick Gordon on 2/10/26.
//

import SwiftUI

struct ControlsSectionView: View {
    let primaryTitle: String
    let isPrimaryDisabled: Bool
    let orderLength: Binding<Int>
    let totalSquares: Int
    let isStepperDisabled: Bool
    let onPrimaryTap: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Button(primaryTitle) {
                onPrimaryTap()
            }
            .buttonStyle(.borderedProminent)
            .disabled(isPrimaryDisabled)

            Stepper(value: orderLength, in: 4...totalSquares) {
                Text("Order length: \(orderLength.wrappedValue)")
                    .font(.system(.subheadline, design: .rounded))
            }
            .disabled(isStepperDisabled)
        }
    }
}
