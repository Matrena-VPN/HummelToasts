// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HummelToasts",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ToastsCore",
            targets: ["ToastsCore"]
        ),
        .library(
            name: "Toasts",
            targets: ["ToastsCore", "Toasts"]
        )
    ],
    targets: [
        .foundation(),
        .toasts(),
        .core(),
    ]
)

extension Target {
    static func foundation() -> Target {
        .target(
            name: "ToastsFoundation",
            path: "./Sources/Foundation"
        )
    }
    
    static func toasts() -> Target {
        .target(
            name: "Toasts",
            dependencies: [
                "ToastsFoundation"
            ]
        )
    }
    
    static func core() -> Target {
        .target(
            name: "ToastsCore",
            dependencies: [
                "ToastsFoundation",
                "Toasts"
            ],
            path: "./Sources/Core",
            resources: [
                .process("./Resources/Localizable.xcstrings")
            ]
        )
    }
}
