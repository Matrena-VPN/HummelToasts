//
//  HMNotification.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

import ToastsFoundation
import Toasts

@MainActor
public struct HMNotification {
    public static func custom<T: ToastsFoundation.Notification>(_ notification: T) {
        NotificationCenter.notification.post(
            name: .willPostNotification,
            object: notification
        )
    }
    
    public static func dismissAll() {
        NotificationCenter.notification.post(
            name: .willDisappearNotification,
            object: nil
        )
    }
}
