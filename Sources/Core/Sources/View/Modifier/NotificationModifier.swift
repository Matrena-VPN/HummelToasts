//
//  NotificationModifier.swift
//  HummelToasts
//
//  Created by Archibbald on 3/10/25.
//

import SwiftUI

import Toasts
import ToastsFoundation

public extension View {
    @ViewBuilder
    func notification<Notification: ToastsFoundation.Notification>(
        isPresented: Binding<Bool>,
        notification: Notification
    ) -> some View {
        self
            .modifier(NotificationModifier(isPresented: isPresented, notification: notification))
    }
    
    @ViewBuilder
    func notification<T: Equatable, Notification: ToastsFoundation.Notification>(
        item: Binding<T?>,
        @ViewBuilder content: @escaping (T) -> Notification
    ) -> some View {
        self
            .modifier(NotificationModifier(item: item, content: content))
    }
}

struct NotificationModifier<Notification: ToastsFoundation.Notification, Item: Equatable>: ViewModifier {
    @Binding var item: Optional<Item>
    var content: (Item) -> Notification
    
    @State var ignoreState = false
    
    init(isPresented: Binding<Item>, notification: Notification) where Item == Bool {
        self._item = Binding(
            get: { isPresented.wrappedValue },
            set: { isPresented.wrappedValue = $0 ?? false }
        )
        self.content = { _ in notification }
    }
    
    init(item: Binding<Item?>, content: @escaping (Item) -> Notification) {
        self._item = item
        self.content = content
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard let item else { return }
                
                let notification = self.content(item)
                let isPresented = item as? Bool
                
                guard let isPresented, isPresented else { return }
                
                HMNotification.custom(notification)
            }
            .onAppear {
                guard !(item is Bool?) else { return }
                guard let item else { return }
                
                let notification = self.content(item)
                
                HMNotification.custom(notification)
            }
            .onChange(of: item) { newState in
                guard let newState else { return }
                
                let notification = self.content(newState)
                let isShouldPresent = if let isPresented = item as? Bool {
                    isPresented
                } else {
                    item != nil
                }                                
                
                if isShouldPresent {
                    HMNotification.custom(notification)
                } else {
                    HMNotification.dismissAll()
                }
            }
            .onReceive(
                NotificationCenter.notification.publisher(for: .didDisappearNotification),
                perform: { _ in
                    if item is Bool {
                        item = false as? Item
                    } else {
                        item = nil
                    }
                }
            )
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var isPresented: Bool = false
    
    Button("Present") {
        isPresented.toggle()
    }
    .notification(
        isPresented: $isPresented,
        notification: Snack {
            SnackRole.failure.icon
                .scaledToFit()
                .frame(width: 25, height: 25)
        } content: {
            Text("Sorry. Something went wrong...")
                .font(.subheadline)
        }
    )
    .configureToasts()
}
