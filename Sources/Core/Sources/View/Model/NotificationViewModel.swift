//
//  NotificationViewModel.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import Combine
import SwiftUI

import ToastsFoundation
import Toasts

@MainActor
final class NotificationViewModel: ObservableObject {
    typealias Notification = ToastsFoundation.Notification
    
    @Published var notification: (any Notification)?
    
    var presentNotificationsHandlerTask: Task<Void, Never>? = nil
    var dismissNotificationsHandlerTask: Task<Void, Never>? = nil
    var notificationCancelationTask: Task<Void, Error>? = nil
    var cancellable: Set<AnyCancellable> = []
    
    init() {
        presentNotificationsHandlerTask = Task { [weak self] in
            let center = NotificationCenter.notification
            let queue = center.notifications(named: .willPostNotification)
                .compactMap { $0.object as? (any Notification) }
            
            for await notification in queue {
                withAnimation(notification.animation) {
                    self?.notification = notification
                }
            }
        }
        
        dismissNotificationsHandlerTask = Task { [weak self] in
            let center = NotificationCenter.notification
            let queue = center.notifications(named: .willDisappearNotification)
                .map { _ in () }
                
            for await _ in queue {
                guard let notification = self?.notification else { continue }
                
                withAnimation(notification.animation) {
                    self?.notification = nil
                }
            }
        }
        
        $notification
            .dropFirst()
            .filter { $0 == nil }
            .sink { _ in
                NotificationCenter.notification.post(name: .didDisappearNotification, object: nil)
            }
            .store(in: &cancellable)
        
        $notification
            .dropFirst()
            .compactMap { $0 as? (any Toast) }
            .removeDuplicates(by: { $0.id == $1.id })
            .sink { [weak self] toast in
                self?.notificationCancelationTask?.cancel()
                self?.notificationCancelationTask = Task {
                    let nanoseconds = UInt64(toast.lifetime) * 1_000_000_000
                    
                    try await Task.sleep(nanoseconds: nanoseconds)
                    
                    guard self?.notification?.id == toast.id else { return }
                    
                    withAnimation(toast.animation) {
                        self?.notification = nil
                    }
                }
            }
            .store(in: &cancellable)
    }    
}
