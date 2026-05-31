//
//  SwiftUIExampleHostingController.swift
//  ThemeSwitcher
//
//  Created by Codex on 31.05.2026.
//  Copyright © 2026 Andrey Raevnev. All rights reserved.
//

import SwiftUI
import UIKit

final class SwiftUIExampleHostingController: UIHostingController<SwiftUIExampleRootView> {

    init() {
        super.init(rootView: SwiftUIExampleRootView())
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
