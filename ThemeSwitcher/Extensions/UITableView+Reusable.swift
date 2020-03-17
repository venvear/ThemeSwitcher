//
//  UITableView+Reusable.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    final func register<T: UITableViewCell>(_ cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    final func register<T: UITableViewHeaderFooterView>(_ headerType: T.Type)
        where T: Reusable {
            self.register(headerType.self, forHeaderFooterViewReuseIdentifier: headerType.reuseIdentifier)
    }

    final func dequeue<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }

    final func dequeue<T: UITableViewHeaderFooterView>(headerType: T.Type = T.self) -> T
        where T: Reusable {
            guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: headerType.reuseIdentifier) as? T else {
                fatalError(
                    "Failed to dequeue a header with identifier \(headerType.reuseIdentifier) matching type \(headerType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return header
    }
}
