//
//  Snack.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

import ToastsFoundation

public struct Snack<Image: View, Content: View>: Toast {
    @ViewBuilder var image: Image
    @ViewBuilder var content: Content
    
    public var id = UUID()
    public var isControlGesturesActive = false
    
    @Environment(\.dismissNotification) var dismiss
    
    public init(
        @ViewBuilder image: () -> Image,
        @ViewBuilder content: () -> Content
    ) {
        self.image = image()
        self.content = content()
    }
    
    public var body: some View {
        HStack(spacing: 15) {
            image
            
            content
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                dismiss()
            } label: {
                SwiftUI.Image(systemName: "xmark")
                    .foregroundStyle(.gray)
            }
        }
        .padding(10)
        .background(.regularMaterial, in: .rect(cornerRadius: 12))
        .padding()
        .transition(
            .asymmetric(
                insertion: .offset(y: 100),
                removal: .scale(scale: 0.95).combined(with: .opacity)
            )
        )
    }
}

@available(iOS 17.0, *)
#Preview("Snack", traits: .sizeThatFitsLayout) {
    Snack {
        Image(systemName: "flame")
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
    } content: {
        Text("Извините. Что-то пошло не так...")
            .font(.subheadline)
    }
    .padding()
}
