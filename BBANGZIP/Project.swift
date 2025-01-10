import ProjectDescription
import ProjectDescriptionHelpers

let infoPlist: [String: Plist.Value] = [
    "CFBundleDisplayName": "제 과제 빵점",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen.storyboard",
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ],
            ]
        ]
    ],
    "CFBundleURLTypes": [
        [
            "CFBundleTypeRole": "Editor",
            "CFBundleURLSchemes": ["kakao$(KAKAO_NATIVE_APP_KEY)"]
        ],
    ],
    "LSApplicationQueriesSchemes": [
        "kakaokompassauth",
        "kakaolink",
        "kakao$(KAKAO_NATIVE_APP_KEY)"
    ],
    "KAKAO_NATIVE_APP_KEY": "$(KAKAO_NATIVE_APP_KEY)",
    "BASE_URL": "$(BASE_URL)",
    "NSAppTransportSecurity": [
        "NSAllowsArbitraryLoads": true
    ],
    "UIUserInterfaceStyle": "Light",
    "UISupportedInterfaceOrientations": [
        "UIInterfaceOrientationPortrait"
    ]
]

private let settings = Settings.settings(
    base: ["SWIFT_VERSION": "6.0"],
    configurations: [
    .debug(name: .debug, xcconfig:
            .relativeToRoot("BBANGZIP/Resources/Config/Secrets.xcconfig")),
    .release(name: .release, xcconfig: .relativeToRoot("BBANGZIP/Resources/Config/Secrets.xcconfig"))
])

private let moduleName = "BBANGZIP"

let project = Project.makeModule(
    name: moduleName,
    destinations: [.iPhone],
    product: .app,
    bundleId: "io.tuist.BBANGZIP",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["BBANGZIP/Sources/**"],
    resources: ["BBANGZIP/Resources/**"],
    dependencies: [
        .external(name: "Alamofire", condition: .none),
        .external(name: "KakaoSDKAuth", condition: .none),
        .external(name: "KakaoSDKCommon", condition: .none),
        .external(name: "KakaoSDKUser", condition: .none),
    ],
    settings: settings
)

let testTarget = Project.makeModule(
    name: "\(moduleName)Tests",
    destinations: .iOS,
    product: .unitTests,
    bundleId: "\(moduleName)Tests",
    infoPlist: .default,
    sources: ["BBANGZIP/Tests/**"],
    resources: [],
    dependencies: [
        .target(name: moduleName)
    ]
)
