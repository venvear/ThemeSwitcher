# ThemeSwitcher

ThemeSwitcher is a small iOS sample app that demonstrates how to add `System`, `Light`, and `Dark` appearance modes with both UIKit and SwiftUI examples.

The project was originally created as a companion repository for a Habr article about adding Dark Mode support in iOS. It now keeps the original flow as a UIKit example and adds a SwiftUI variant hosted inside the same app. UIKit remains the base, while shared theme state is reused from SwiftUI through a small `ThemeManager`.

<img src="https://github.com/venvear/ThemeSwitcher/blob/master/images/app.GIF?raw=true" alt="ThemeSwitcher demo" width="300"/>

## Article

The original write-up is available on Habr:

[Adding Dark Theme to iOS](https://habr.com/ru/company/bcs_company/blog/493096/)

## What This Project Shows

- Switching between `System`, `Light`, and `Dark` themes inside the app.
- Comparing the current UIKit implementation with a SwiftUI implementation in a dedicated tab.
- Persisting the selected theme with `UserDefaults`.
- Applying the active theme to app windows through `overrideUserInterfaceStyle`.
- Using `.unspecified` for `System` so UIKit follows the current iOS appearance automatically.
- Presenting the theme picker with `UISheetPresentationController`.
- Defining app semantic colors in Asset Catalog color sets.
- Showing adaptive images, app colors, UIKit semantic colors, and controls in a dedicated demo tab.
- Building a simple UIKit app without storyboards for the main UI.
- Using `UITableViewDiffableDataSource`, Dynamic Type, and VoiceOver-friendly cell labels in the feed.

## How It Works

Theme state lives in `ThemeSwitcher/Theme`.

```mermaid
flowchart LR
    User["User selects theme"] --> Panel["ThemePanelVC"]
    SwiftUI["SwiftUI Picker"] --> API
    Panel --> API["Theme.setActive()"]
    API --> Manager["ThemeManager.apply(_:)"]
    Manager --> Defaults["Persist app_theme raw value"]
    Manager --> Windows["App windows overrideUserInterfaceStyle"]
    Windows --> System["System = .unspecified"]
    Windows --> Fixed["Light/Dark = fixed style"]
```

`Theme` defines the available modes and keeps persisted raw values stable:

- `system = 0`
- `light = 1`
- `dark = 2`

`Theme.displayName` is the user-facing label used by the UIKit sheet and the SwiftUI menu picker. `ThemeManager` owns the application step: it saves the chosen value and applies the matching `UIUserInterfaceStyle` to app windows. For `System`, it applies `.unspecified`, which means the app follows iOS Light or Dark Mode without a helper window.

The UIKit example uses `ThemePanelVC` with `UISheetPresentationController`. The SwiftUI example is embedded through `SwiftUIExampleHostingController` and calls the same public API, so both variants share persisted state and window-level appearance.

## Key Files

- `ThemeSwitcher/Theme/Theme.swift` - theme enum, raw values, labels, and persistence.
- `ThemeSwitcher/Theme/ThemeManager.swift` - window-level theme application.
- `ThemeSwitcher/Screens/Theme/ThemePanelVC.swift` - iOS 15 sheet-based theme selector.
- `ThemeSwitcher/Screens/MainTabs/Demo/ThemeDemoVC.swift` - UIKit palette, semantic colors, adaptive image, and component examples.
- `ThemeSwitcher/Screens/MainTabs/Feed` - UIKit diffable feed table and accessible cells.
- `ThemeSwitcher/Screens/Login/LoginVC.swift` - UIKit login validation and theme entry point.
- `ThemeSwitcher/Screens/MainTabs/Profile/ProfileVC.swift` - UIKit profile details and logout.
- `ThemeSwitcher/Screens/SwiftUIExample` - SwiftUI feed, demo, profile, and hosting controller.
- `ThemeSwitcher/Resources/Assets.xcassets/Colors` - semantic color sets such as `appBackground`, `primaryText`, `secondaryText`, and `separator`.
- `ThemeSwitcherTests/ThemeSwitcherTests.swift` - persistence, raw value, label, user, and `ThemeManager` tests.

## Screenshots

Fresh simulator screenshots from the current UIKit build are kept in `images/screenshots/`:

| Light | Dark | System follows iOS |
| --- | --- | --- |
| <img src="images/screenshots/forced-light.png" alt="ThemeSwitcher forced Light theme" width="220"/> | <img src="images/screenshots/forced-dark.png" alt="ThemeSwitcher forced Dark theme" width="220"/> | <img src="images/screenshots/system-light.png" alt="ThemeSwitcher System theme in light system appearance" width="220"/> |

System mode was also smoke-tested against dark iOS appearance: `images/screenshots/system-dark.png`.

Original article screenshots are still kept in `images/`:

- Light flow: `images/1_l.jpg`, `images/2_l.jpg`, `images/3_l.jpg`, `images/4_l.jpg`, `images/5_l.jpg`
- Dark flow: `images/1_d.jpg`, `images/2_d.jpg`, `images/3_d.jpg`, `images/4_d.jpg`, `images/5_d.jpg`
- System colors: `images/systemColors.jpg`

## How To Reuse In Your App

1. Copy `Theme.swift`, `ThemeManager.swift`, `Theme+app.swift`, `UIWindow+theme.swift`, and `Persist.swift`.
2. Keep your theme enum raw values stable if you already persist user choices.
3. Call `window.initTheme()` before showing a new app window.
4. Present your own picker and call `theme.setActive()` when the user chooses a mode.
5. Prefer Asset Catalog color sets for app semantic colors, then use those colors throughout UIKit views.
6. In SwiftUI, bind a `Picker` to `Theme`, call `theme.setActive()` on changes, and wrap UIKit colors with `Color(UIColor.Pallete.primaryText)` or your own semantic assets.

## Requirements

- Xcode 26 or newer
- Swift 6 language mode
- iOS 15.0 or newer

## Build And Test

Open `ThemeSwitcher.xcworkspace` or `ThemeSwitcher.xcodeproj` in Xcode and run the `ThemeSwitcher` scheme.

From the command line:

```sh
xcodebuild -workspace ThemeSwitcher.xcworkspace -scheme ThemeSwitcher -destination 'generic/platform=iOS Simulator' build
xcodebuild -workspace ThemeSwitcher.xcworkspace -scheme ThemeSwitcher -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.6' test
```

If your simulator list uses a different runtime, replace `OS=18.6` with an installed iOS Simulator version from `xcrun simctl list devices available`.

Manual smoke checks:

- Launch in `System` mode.
- Switch to `Light`, then `Dark`, then back to `System`.
- Log out, log in with a non-empty username, and confirm profile data updates.
- Test Dynamic Type with Large and Accessibility sizes on login, feed, theme sheet, demo, and profile.

## Notes

The project does not depend on CocoaPods, SnapKit, or any other third-party dependency. Layout is implemented with native Auto Layout constraints so the sample can be opened and built directly.
