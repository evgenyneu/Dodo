// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Dodo",
    products: [
        .library(name: "Dodo", targets: ["Dodo"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Dodo", dependencies: [], path: "Dodo"),
        .testTarget(
            name: "DodoTests",
            dependencies: ["Dodo"],
            path: "DodoTests"
        )
    ]
)
