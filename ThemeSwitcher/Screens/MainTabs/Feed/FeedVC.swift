//
//  FeedVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    private enum Section {
        case main
    }

    private lazy var dataSource = UITableViewDiffableDataSource<Section, Feed>(tableView: tableView) { tableView, indexPath, feed in
        let cell: FeedCell = tableView.dequeue(for: indexPath)
        cell.set(data: feed)
        return cell
    }
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.Pallete.appBackground
        tv.estimatedRowHeight = 75
        tv.rowHeight = UITableView.automaticDimension
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        tv.register(FeedCell.self)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.appBackground
        
        view.addAutoLayoutSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        applySnapshot()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Feed>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Feed.data)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}

extension FeedVC: UITableViewDelegate {}
