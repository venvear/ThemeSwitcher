//
//  FeedVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit
import SnapKit

class FeedVC: UIViewController {
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.Pallete.white
        tv.estimatedRowHeight = 75
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        tv.register(FeedCell.self)
        return tv
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("FeedVC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.background
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension FeedVC: UITableViewDelegate {
    
}

extension FeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Feed.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedCell = tableView.dequeue(for: indexPath)
        let data = Feed.data[indexPath.row]
        cell.set(data: data)
        return cell
    }
}
