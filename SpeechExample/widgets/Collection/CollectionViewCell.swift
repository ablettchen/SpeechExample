//
//  CollectionViewCell.swift
//  BestLe
//
//  Created by ablett on 2019/7/10.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
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
     An initializer that initializes the object with a CGRect object.
     If AutoLayout is used, it is better to initilize the instance
     using the init() initializer.
     - Parameter frame: A CGRect instance.
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    open func prepare() {
        contentScaleFactor = Screen.scale
        backgroundColor = .white
    }
    
    
}
