//
//  HMNotification+Snack.swift
//  HummelToasts
//
//  Created by Archibbald on 3/3/25.
//

import SwiftUI

import Toasts

public extension HMNotification {
    static func snack(
        _ key: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil,
        role: SnackRole
    ) {
        let snack = Snack {
            role.icon
                .scaledToFit()
                .frame(width: 25, height: 25)
        } content: {
            Text(key, tableName: tableName, bundle: bundle, comment: comment)
                .font(.subheadline)
        }
   
        custom(snack)
    }
    
    static func snack<Content: StringProtocol>(_ content: Content, role: SnackRole) {
        let snack = Snack {
            role.icon
                .scaledToFit()
                .frame(width: 25, height: 25)
        } content: {
            Text(content)
                .font(.subheadline)
        }
   
        custom(snack)
    }
}

#Preview("Snack Presentation") {
    Button("Present") {
        HMNotification.snack("Sorry. Something went wrong...", role: .failure)
    }
    .configureToasts()
}

@available(iOS 17.0, *)
#Preview("Snack environment") {
    @Previewable @State var locale = Locale(identifier: "en")
    
    VStack {
        Button {
            HMNotification.snack(
                "Sorry. Something went wrong...",
                bundle: .module,
                role: .failure
            )
        } label: {
            Text("Present", bundle: .module)
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        
        Button {
            locale = locale.identifier == "en" ? Locale(identifier: "ru") : Locale(identifier: "en")
        } label: {
            Text("Toggle localization", bundle: .module)
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
    }
    .padding()
    .configureToasts()
    .environment(\.locale, locale)
}
