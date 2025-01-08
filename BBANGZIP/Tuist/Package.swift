// swift-tools-version: 5.7
@preconcurrency
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "Alamofire": .framework,
        "KakaoOpenSDK": .framework,
    ]
)
#endif

let kakaoVersion = "2.23.0"
let alamofireVersion = "5.10.2"

let package = Package(
    name: "BBANGZIP",
    dependencies: [
        .package(url: "https://github.com/kakao/kakao-ios-sdk", .upToNextMajor(from: Version(kakaoVersion)!)),
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: Version(alamofireVersion)!)),
    ]
)
