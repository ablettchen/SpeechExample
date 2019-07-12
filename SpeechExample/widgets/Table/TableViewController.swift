//
//  TableViewController.swift
//  BestLe
//
//  Created by ablett on 2019/7/8.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public protocol TableViewDelegate: UITableViewDelegate {}

public protocol TableViewDataSource: UITableViewDataSource {
    /**
     Retrieves the data source items for the tableView.
     - Returns: An Array of DataSourceItem objects.
     */
    var dataSourceItems: [DataSourceItem] { get }
}

public class TableViewController: ViewController {
    /// A reference to a Reminder.
    public let tableView = TableView()
    
    /// An Array of DataSourceItems.
    open var dataSourceItems = [DataSourceItem]()
    
    open override func prepare() {
        super.prepare()
        prepareTableView()
    }
}

extension TableViewController {
    /// Prepares the tableView.
    fileprivate func prepareTableView() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 34, right: 0)
        self.view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension TableViewController: TableViewDelegate {}

extension TableViewController: TableViewDataSource {
    @objc
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceItems.count
    }
    
    @objc
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
