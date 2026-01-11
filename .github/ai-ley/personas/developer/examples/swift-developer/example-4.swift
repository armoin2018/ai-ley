// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MyApp",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "MyApp", targets: ["MyApp"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.5.0")
    ],
    targets: [
        .target(name: "MyApp", dependencies: ["Alamofire"]),
        .testTarget(name: "MyAppTests", dependencies: ["MyApp"])
    ]
)