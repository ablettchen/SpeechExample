//
//  TableViewCell.swift
//  BestLe
//
//  Created by ablett on 2019/7/7.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public class TableViewCell: UITableViewCell {
    
    /// A property that accesses the backing layer's background
    @IBInspectable
    open override var backgroundColor: UIColor? {
        didSet {
            layer.backgroundColor = backgroundColor?.cgColor
        }
    }
    
    /**
     An initializer that initializes the object with a NSCoder object.
     - Parameter aDecoder: A NSCoder instance.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    /**
     An initializer that initializes the object.
     - Parameter style: A UITableViewCellStyle enum.
     - Parameter reuseIdentifier: A String identifier.
     */
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        prepare()
    }

    public func prepare() {
        selectionStyle = .none
        separatorInset = .zero
        contentScaleFactor = Screen.scale
        imageView?.isUserInteractionEnabled = false
        textLabel?.isUserInteractionEnabled = false
        detailTextLabel?.isUserInteractionEnabled = false
    }
    
}
