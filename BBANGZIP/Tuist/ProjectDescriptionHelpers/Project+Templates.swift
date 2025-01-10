//
//  Project+Templates.swift
//  BBANGZIPManifests
//
//  Created by 송여경 on 1/9/25.
//
import ProjectDescription

extension Project {
  private static let organizationName = "com.bbangzip."
  private static let deploymentTarget = "16.0"

  public static func makeModule(
    name: String,
    destinations: Destinations,
    product: Product,
    bundleId: String,
    infoPlist: InfoPlist = .default,
    sources: SourceFilesList = ["Sources/**"],
    resources: ResourceFileElements? = nil,
    entitlements: Entitlements? = nil,
    dependencies: [TargetDependency] = [],
    target: Target? = nil,
    settings: Settings? = nil
  ) -> Project {

    let target = Target.target(
      name: name,
      destinations: destinations,
      product: product,
      bundleId: organizationName + bundleId,
      deploymentTargets: .iOS(deploymentTarget),
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      entitlements: entitlements,
      scripts: [],
      dependencies: dependencies,
      settings: settings
    )

    return Project(
      name: name,
      organizationName: organizationName,
      options: .options (
        defaultKnownRegions: ["en", "ko"],
        developmentRegion: "ko"
        ),
      
      targets: [target]
    )
  }
}

