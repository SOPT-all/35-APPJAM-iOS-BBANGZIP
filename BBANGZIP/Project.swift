import ProjectDescription

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
        "UIInterfaceOrientationPortait"
    ]
]      

private let settings = Settings.settings(configurations: [
    .debug(name: .debug, xcconfig:
            .relativeToRoot("BBANGZIP/Resources/Config/Secrets.xcconfig")),
    .release(name: .release, xcconfig: .relativeToRoot("BBANGZIP/Resources/Config/Secrets.xcconfig")),
])

let project = Project(
    name: "BBANGZIP",
    targets: [
        .target(
            name: "BBANGZIP",
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
        ),
        .target(
            name: "BBANGZIPTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.BBANGZIPTests",
            infoPlist: .default,
            sources: ["BBANGZIP/Tests/**"],
            resources: [],
            dependencies: [.target(name: "BBANGZIP")]
        ),
    ]
)
