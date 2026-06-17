//
//  SwiftUIExampleRootView.swift
//  ThemeSwitcher
//
//  Created by Codex on 31.05.2026.
//  Copyright © 2026 Andrey Raevnev. All rights reserved.
//

import SwiftUI
import UIKit

@MainActor
struct SwiftUIExampleRootView: View {

    @State private var selectedTheme = Theme.current

    var body: some View {
        TabView {
            NavigationView {
                SwiftUIFeedView()
                    .navigationTitle("SwiftUI Feed")
                    .toolbar { themePickerToolbar }
            }
            .tabItem {
                Label("Feed", systemImage: "list.bullet")
            }

            NavigationView {
                SwiftUIThemeDemoView()
                    .navigationTitle("SwiftUI Demo")
                    .toolbar { themePickerToolbar }
            }
            .tabItem {
                Label("Demo", systemImage: "circle.lefthalf.filled")
            }

            NavigationView {
                SwiftUIProfileView()
                    .navigationTitle("SwiftUI Profile")
                    .toolbar { themePickerToolbar }
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
        .accentColor(Color(UIColor.Pallete.primaryText))
        .onAppear {
            selectedTheme = Theme.current
        }
        .onChange(of: selectedTheme) { theme in
            theme.setActive()
        }
    }

    private var themePickerToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Picker("App appearance", selection: $selectedTheme) {
                ForEach(Theme.allCases, id: \.self) { theme in
                    Text(theme.displayName).tag(theme)
                }
            }
            .pickerStyle(.menu)
            .accessibilityLabel("Choose app appearance")
            .accessibilityValue(selectedTheme.displayName)
        }
    }
}

@MainActor
private struct SwiftUIFeedView: View {

    var body: some View {
        List {
            Section {
                ForEach(Feed.data, id: \.id) { feed in
                    SwiftUIFeedRow(feed: feed)
                        .listRowBackground(Color(UIColor.Pallete.appBackground))
                }
            } header: {
                Text("SwiftUI example")
            } footer: {
                Text("The rows use the same Feed model and adaptive colors as the UIKit table.")
            }
        }
        .listStyle(.plain)
        .background(Color(UIColor.Pallete.appBackground).ignoresSafeArea())
    }
}

@MainActor
private struct SwiftUIFeedRow: View {

    let feed: Feed

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let image = UIImage.app(feed.image) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(Color(UIColor.Pallete.separator), lineWidth: 1)
                    }
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Text(feed.name)
                        .font(.headline)
                        .foregroundColor(Color(UIColor.Pallete.primaryText))

                    Text("• \(feed.date)")
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.Pallete.secondaryText))
                }

                Text(feed.text)
                    .font(.body)
                    .foregroundColor(Color(UIColor.Pallete.secondaryText))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
    }
}

@MainActor
private struct SwiftUIThemeDemoView: View {

    private let columns = [
        GridItem(.adaptive(minimum: 130), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI variant")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(UIColor.Pallete.primaryText))

                    Text("The same Theme API drives this SwiftUI version while UIKit remains the host app.")
                        .font(.body)
                        .foregroundColor(Color(UIColor.Pallete.secondaryText))
                }

                colorSection(
                    title: "App semantic colors",
                    colors: [
                        ColorSample(title: "appBackground", color: UIColor.Pallete.appBackground),
                        ColorSample(title: "primaryText", color: UIColor.Pallete.primaryText),
                        ColorSample(title: "secondaryText", color: UIColor.Pallete.secondaryText),
                        ColorSample(title: "separator", color: UIColor.Pallete.separator)
                    ]
                )

                colorSection(
                    title: "UIKit semantic colors",
                    colors: [
                        ColorSample(title: "systemBackground", color: .systemBackground),
                        ColorSample(title: "label", color: .label),
                        ColorSample(title: "secondaryLabel", color: .secondaryLabel),
                        ColorSample(title: "systemBlue", color: .systemBlue)
                    ]
                )

                auditChecklistSection
                adaptiveImageSection
                controlsSection
            }
            .padding(20)
        }
        .background(Color(UIColor.Pallete.appBackground).ignoresSafeArea())
    }

    private func colorSection(title: String, colors: [ColorSample]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color(UIColor.Pallete.primaryText))

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(colors, id: \.title) { sample in
                    ColorSampleTile(sample: sample)
                }
            }
        }
    }

    private var auditChecklistSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Theme audit checklist")
                .font(.headline)
                .foregroundColor(Color(UIColor.Pallete.primaryText))

            Text("Reusable checks to run when adding this theme switcher to another screen.")
                .font(.footnote)
                .foregroundColor(Color(UIColor.Pallete.secondaryText))

            ForEach(ThemeAuditItem.defaultItems, id: \.self) { item in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(UIColor.Pallete.primaryText))
                        .imageScale(.medium)
                        .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.subheadline)
                            .foregroundColor(Color(UIColor.Pallete.primaryText))

                        Text(item.detail)
                            .font(.footnote)
                            .foregroundColor(Color(UIColor.Pallete.secondaryText))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.Pallete.secondaryBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(item.accessibilityLabel)
            }
        }
    }

    private var adaptiveImageSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Adaptive image")
                .font(.headline)
                .foregroundColor(Color(UIColor.Pallete.primaryText))

            if let image = UIImage.app(.login) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .background(Color(UIColor.Pallete.secondaryBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .accessibilityLabel("Login artwork changes between light and dark appearances")
            }

            Text("SwiftUI renders the same adaptive asset catalog image as the UIKit login screen.")
                .font(.footnote)
                .foregroundColor(Color(UIColor.Pallete.secondaryText))
        }
    }

    private var controlsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Controls")
                .font(.headline)
                .foregroundColor(Color(UIColor.Pallete.primaryText))

            TextField("Adaptive text field", text: .constant(""))
                .textFieldStyle(.roundedBorder)

            Button("Primary action") {}
                .buttonStyle(PrimarySwiftUIButtonStyle())
        }
    }
}

@MainActor
private struct SwiftUIProfileView: View {

    var body: some View {
        Form {
            Section("Example") {
                ProfileValueRow(title: "Variant", value: "SwiftUI")
                ProfileValueRow(title: "Current theme", value: Theme.current.displayName)
            }

            Section("Current user") {
                ProfileValueRow(title: "Username", value: User.current?.name ?? "empty")
                ProfileValueRow(title: "Email", value: User.current?.email ?? "empty")
            }

            Section {
                Button("Log out", role: .destructive) {
                    User.current = nil
                    (UIApplication.shared.delegate as? AppDelegate)?.showLoginScreen()
                }
            }
        }
        .background(Color(UIColor.Pallete.appBackground).ignoresSafeArea())
    }
}

@MainActor
private struct ProfileValueRow: View {

    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(UIColor.Pallete.secondaryText))

            Spacer()

            Text(value)
                .font(.headline)
                .foregroundColor(Color(UIColor.Pallete.primaryText))
                .multilineTextAlignment(.trailing)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct ColorSample {
    let title: String
    let color: UIColor
}

@MainActor
private struct ColorSampleTile: View {

    let sample: ColorSample

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(sample.color))
                .frame(height: 44)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(UIColor.Pallete.separator), lineWidth: 1)
                }

            Text(sample.title)
                .font(.footnote)
                .foregroundColor(Color(UIColor.Pallete.primaryText))
                .lineLimit(2)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.Pallete.secondaryBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .accessibilityElement(children: .combine)
    }
}

@MainActor
private struct PrimarySwiftUIButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 44)
            .foregroundColor(Color(UIColor.Pallete.inverseText))
            .background(Color(UIColor.Pallete.primaryText).opacity(configuration.isPressed ? 0.72 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
