//
//  PassthroughWindow.swift
//  HummelToasts
//
//  Created by Archibbald on 2/28/25.
//

import UIKit

final class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if #available(iOS 18, *) {
            let view = super.hitTest(point, with: event)
            
            guard let view, _hitTest(point, from: view) != rootViewController?.view else { return nil }
            
            return view
        } else {
            let view = super.hitTest(point, with: event)
            
            guard view != rootViewController?.view else { return nil }
            
            return view
        }
    }
    
    private func _hitTest(_ point: CGPoint, from view: UIView) -> UIView? {
        let converted = convert(point, to: view)
        
        guard view.bounds.contains(converted)
                && view.isUserInteractionEnabled
                && !view.isHidden
                && view.alpha > 0
        else { return nil }
        
        return view.subviews.reversed()
            .reduce(Optional<UIView>.none) { result, view in
                result ?? _hitTest(point, from: view)
            } ?? view
    }
}
