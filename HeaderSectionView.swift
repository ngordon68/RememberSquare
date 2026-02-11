//
//  HeaderSectionView.swift
//  RememberSquare
//
//  Created by Nick Gordon on 2/10/26.
//

import SwiftUI

struct HeaderSectionView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Remember Square")
                .font(.system(.largeTitle, design: .rounded))
                .bold()

            Text("Watch the sequence, then tap the squares in order.")
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
