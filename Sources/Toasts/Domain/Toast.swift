//
//  Toast.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import SwiftUI

import ToastsFoundation

public protocol Toast: ToastsFoundation.Notification {    
    var lifetime: TimeInterval { get }
    var isControlGesturesActive: Bool { get }
}

public extension Toast {
    var alignment: VerticalAlignment { .bottom }
    var lifetime: TimeInterval { 4 }
    var isControlGesturesActive: Bool { true }
    var isBackgroundDarkened: Bool { false }
}
