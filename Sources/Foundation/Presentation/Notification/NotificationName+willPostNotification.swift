//
//  NotificationName+willPostNotification.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import Foundation

public extension Foundation.Notification.Name {
    static var willPostNotification: Foundation.Notification.Name { .init("HummelToasts.willPostNotification") }
    static var willDisappearNotification: Foundation.Notification.Name { .init("HummelToasts.willDisappearNotification") }
    static var didDisappearNotification: Foundation.Notification.Name { .init("HummelToasts.didDisappearNotification") }
}
