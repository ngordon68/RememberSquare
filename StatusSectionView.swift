//
//  StatusSectionView.swift
//  RememberSquare
//
//  Created by Nick Gordon on 2/10/26.
//

import SwiftUI

struct StatusSectionView: View {
    let statusText: String
    let detail: String?
    let showsSequence: Bool
    let sequenceDescription: String

    var body: some View {
        VStack(spacing: 6) {
            Text(statusText)
                .font(.system(.headline, design: .rounded))

            if let detail {
                Text(detail)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            if showsSequence {
                Text("Sequence: \(sequenceDescription)")
                    .font(.system(.footnote, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
