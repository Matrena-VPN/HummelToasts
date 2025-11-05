//
//  DismissToast.swift
//  HummelToasts
//
//  Created by Archibbald on 3/3/25.
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var dismissNotification = DismissNotificationAction(dismissCurrent: {})
}
