# BeerApp

An iOS application that aims to use SwiftUI and Combine, modular, testable.
## Requirements

+ XCode 12+
+ Swift 5.0+

## Stack

+ Architecture: MVVM-Coordinator
+ UI stack: SwiftUI + UIKit
+ Diffable data source e Compositional layout
+ FRP framework: Combine
+ POP Network layer
+ Local persistence: CoreData/Realm
+ Dependency manager: Swift Package Manager

## API

Punk API: https://punkapi.com/documentation/v2

## Tools

+ [XcodeGen](https://github.com/yonaskolb/XcodeGen)
+ [Swiftlint to enhance code styling](https://github.com/realm/SwiftLint)

You can install those tools from terminal:

```bash
brew update
brew install swiftlint
brew install xcodegen
```

## Nice to have

+ [XCMetrics](https://github.com/spotify/XCMetrics/blob/main/docs/Run%20the%20Backend%20Locally.md) - [iOS Conf SG 2021](https://www.youtube.com/watch?v=6p8kveO1m00)
+ [Mock with Sourcery](https://www.vadimbulavin.com/mocking-in-swift-using-sourcery/) or [Mockolo](https://github.com/uber/mockolo)
+ Github Actions