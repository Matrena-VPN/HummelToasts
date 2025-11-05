//
//  SnackRole.swift
//  HummelToasts
//
//  Created by Archibbald on 3/3/25.
//

import SwiftUI

public enum SnackRole: Sendable, Hashable {
    case success
    case warning
    case failure
}

public extension SnackRole {
    @ViewBuilder
    var icon: some View {
        switch self {
            case .success:
                Image(systemName: "flame")
                    .resizable()
                    .foregroundStyle(.green)
            case .warning:
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .foregroundStyle(.yellow)
            case .failure:
                Image(systemName: "xmark.shield")
                    .resizable()
                    .foregroundStyle(.red)
        }
    }
}
