//
//  PassthroughWindow.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import UIKit

final class PassthroughWindow: UIWindow {
    private var encounteredEvents = Set<UIEvent>()
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let rootVC = rootViewController, let rootView = rootVC.view else { return nil }
        
        let hitView = super.hitTest(point, with: event)
        
        guard let event else {
            return (hitView == rootView) ? nil : hitView
        }
        
        guard let hitView else {
            encounteredEvents.removeAll()
            return nil
        }
        
        if encounteredEvents.contains(event) {
            encounteredEvents.removeAll()
            return hitView
        }
        
        if #available(iOS 26, *) {
            let p = convert(point, to: rootView)
            if rootView.layer.hitTest(p)?.name == nil {
                encounteredEvents.insert(event)
                return hitView
            }
        }
        
        if hitView == rootView {
            return nil
        }
        
        if #available(iOS 18, *) {
            encounteredEvents.insert(event)
        }
        
        return hitView
    }
}
