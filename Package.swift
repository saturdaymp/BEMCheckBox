// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "BEMCheckBox",
    platforms: [
       .iOS(.v18)
    ],
    products: [
        .library(name: "BEMCheckBox", targets: ["BEMCheckBox"])
    ],
    targets: [
        .target(
            name: "BEMCheckBox",
            dependencies: [],
            swiftSettings: [
                .swiftLanguageMode(.v5)
            ]
        )
    ]
)
