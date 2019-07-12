//
//  TableView.swift
//  BestLe
//
//  Created by ablett on 2019/7/7.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public class TableView: UITableView {
    /**
     An initializer that initializes the object with a NSCoder object.
     - Parameter aDecoder: A NSCoder instance.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        prepare()
    }
    
    /**
     An initializer that initializes the object.
     - Parameter frame: A CGRect defining the view's frame.
     */
    public convenience init(frame: CGRect) {
        self.init(frame: frame, style: .plain)
    }
    
    /**
     Prepares the view instance when intialized. When subclassing,
     it is recommended to override the prepare method
     to initialize property values and other setup operations.
     The super.prepare method should always be called immediately
     when subclassing.
     */
    public func prepare() {
        backgroundColor = .white
        contentScaleFactor = Screen.scale
        separatorStyle = .none
        register(TableViewCell.self, forCellReuseIdentifier: NSStringFromClass(TableViewCell.self))
    }
}
