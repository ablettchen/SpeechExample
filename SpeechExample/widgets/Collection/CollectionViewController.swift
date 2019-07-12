//
//  CollectionViewController.swift
//  BestLe
//
//  Created by ablett on 2019/7/10.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public protocol CollectionViewDelegate: UICollectionViewDelegate {}

public protocol CollectionViewDataSource: UICollectionViewDataSource {
    /**
     Retrieves the data source items for the collectionView.
     - Returns: An Array of DataSourceItem objects.
     */
    var dataSourceItems: [DataSourceItem] { get }
}

open class CollectionViewController: ViewController {
    /// A reference to a Reminder.
    public let collectionView = CollectionView()
    
    open var dataSourceItems = [DataSourceItem]()
    
    open override func prepare() {
        super.prepare()
        prepareCollectionView()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutCollectionView()
    }
}

extension CollectionViewController {
    /// Prepares the collectionView.
    fileprivate func prepareCollectionView() {
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        collectionView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension CollectionViewController {
    /// Sets the frame for the collectionView.
    fileprivate func layoutCollectionView() {
        collectionView.frame = view.bounds
    }
}

extension CollectionViewController: CollectionViewDelegate {}

extension CollectionViewController: CollectionViewDataSource {
    @objc
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceItems.count
    }
    
    @objc
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CollectionViewCell.self), for: indexPath)
    }
}
