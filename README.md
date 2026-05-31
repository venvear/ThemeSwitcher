# ThemeSwitcher

ThemeSwitcher is a small UIKit sample app that demonstrates how to add Light, Dark, and System appearance modes to an iOS application.

The project was originally created as a companion repository for a Habr article about adding Dark Mode support in iOS. It has since been updated to build with modern Xcode and Swift while keeping the original idea intact: the app has its own theme switcher, but the `System` option still follows the current iOS appearance.

<img src="https://github.com/venvear/ThemeSwitcher/blob/master/images/app.GIF?raw=true" alt="ThemeSwitcher demo" width="300"/>

## Article

The original write-up is available on Habr:

[Adding Dark Theme to iOS](https://habr.com/ru/company/bcs_company/blog/493096/)

## What This Project Shows

- Switching between `System`, `Light`, and `Dark` themes inside the app.
- Persisting the selected theme with `UserDefaults`.
- Applying the active theme to app windows through `overrideUserInterfaceStyle`.
- Tracking the real system appearance separately so `System` mode can react when the user changes iOS Dark Mode.
- Defining adaptive colors and images for light and dark appearances.
- Building a simple UIKit app without storyboards for the main UI.
- Presenting a custom bottom sheet for theme selection.

## How It Works

The core theme state lives in `ThemeSwitcher/Theme`.

`Theme` defines the available modes:

- `system`
- `light`
- `dark`

The selected value is saved through the `Persist` property wrapper. When a user selects a new mode, `Theme.setActive()` updates the stored value and applies the corresponding `UIUserInterfaceStyle` to every application window except the helper `themeWindow`.

The helper window is intentionally left untouched. Its only job is to keep reflecting the actual system appearance, which allows the app to know whether iOS itself is currently in Light or Dark Mode.

## Project Structure

- `ThemeSwitcher/AppDelegate.swift` - app launch flow, login/main window switching, and the helper theme window.
- `ThemeSwitcher/Theme` - theme model, persistence, and window appearance application.
- `ThemeSwitcher/Resources` - app image and color helpers.
- `ThemeSwitcher/Screens/Login` - login screen with theme entry point.
- `ThemeSwitcher/Screens/MainTabs` - feed and profile tabs used to demonstrate theme changes across screens.
- `ThemeSwitcher/Screens/Theme` - bottom-sheet theme selector.
- `ThemeSwitcher/Utils` - persistence wrapper and custom bottom modal transition.
- `ThemeSwitcher/Extensions` - UIKit convenience extensions used by the sample UI.

## Requirements

- Xcode 26 or newer
- Swift 6 language mode
- iOS 15.0 or newer

## Build

Open `ThemeSwitcher.xcworkspace` or `ThemeSwitcher.xcodeproj` in Xcode and run the `ThemeSwitcher` scheme.

From the command line:

```sh
xcodebuild -workspace ThemeSwitcher.xcworkspace -scheme ThemeSwitcher -destination 'generic/platform=iOS Simulator' build
```

## Notes

The project no longer depends on CocoaPods or SnapKit. Layout is implemented with native Auto Layout constraints so the sample can be opened and built without installing third-party dependencies.
