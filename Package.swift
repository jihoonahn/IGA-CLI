// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "GptCLI",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "gpt-cli", targets: ["GPT-CLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-log", from: "1.5.2"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.2"),
        .package(url: "https://github.com/Pelagornis/PLCommand.git", from: "1.1.0")
    ],
    targets: [
        .executableTarget(
            name: "GPT-CLI",
            dependencies: [
                "ThirdParty"
            ]
        ),
        .target(
            name: "ThirdParty",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "PLCommand", package: "PLCommand")
            ]
        ),
        .testTarget(
            name: "CLITests",
            dependencies: ["GPT-CLI"]),
    ]
)
