//
//  Notification.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

public protocol Notification: Identifiable, Sendable, View {
    var id: UUID { get }
    var animation: Animation { get }
    var alignment: VerticalAlignment { get }
    var isBackgroundDarkened: Bool { get }
}

public extension Notification {
    var isBackgroundDarkened: Bool { true }
    var alignment: VerticalAlignment { .center }
    var animation: Animation { .default }
}
