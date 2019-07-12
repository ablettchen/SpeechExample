//
//  CollectionView.swift
//  BestLe
//
//  Created by ablett on 2019/7/10.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

open class CollectionView: UICollectionView {
    /// A preset wrapper around contentEdgeInsets.
    open var contentEdgeInsetsPreset: EdgeInsetsPreset {
        get {
            return (collectionViewLayout as? CollectionViewLayout)!.contentEdgeInsetsPreset
        }
        set(value) {
            (collectionViewLayout as? CollectionViewLayout)!.contentEdgeInsetsPreset = value
        }
    }
    
    open var contentEdgeInsets: EdgeInsets {
        get {
            return (collectionViewLayout as? CollectionViewLayout)!.contentEdgeInsets
        }
        set(value) {
            (collectionViewLayout as? CollectionViewLayout)!.contentEdgeInsets = value
        }
    }
    
    /// Scroll direction.
    open var scrollDirection: UICollectionView.ScrollDirection {
        get {
            return (collectionViewLayout as? CollectionViewLayout)!.scrollDirection
        }
        set(value) {
            (collectionViewLayout as? CollectionViewLayout)!.scrollDirection = value
        }
    }
    
    /// A preset wrapper around interimSpace.
    open var interimSpacePreset: InterimSpacePreset {
        get {
            return (collectionViewLayout as? CollectionViewLayout)!.interimSpacePreset
        }
        set(value) {
            (collectionViewLayout as? CollectionViewLayout)!.interimSpacePreset = value
        }
    }
    
    /// Spacing between items.
    @IBInspectable
    open var interimSpace: InterimSpace {
        get {
            return (collectionViewLayout as? CollectionViewLayout)!.interimSpace
        }
        set(value) {
            (collectionViewLayout as? CollectionViewLayout)!.interimSpace = value
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
     - Parameter frame: A CGRect defining the view's frame.
     - Parameter collectionViewLayout: A UICollectionViewLayout reference.
     */
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        prepare()
    }
    
    /**
     An initializer that initializes the object.
     - Parameter collectionViewLayout: A UICollectionViewLayout reference.
     */
    public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        prepare()
    }
    
    /**
     An initializer that initializes the object.
     - Parameter frame: A CGRect defining the view's frame.
     */
    public init(frame: CGRect) {
        let layout = CollectionViewLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        prepare()
    }
    
    /// A convenience initializer that initializes the object.
    public init() {
        let layout = CollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        prepare()
    }
    
    /**
     Prepares the view instance when intialized. When subclassing,
     it is recommended to override the prepare method
     to initialize property values and other setup operations.
     The super.prepare method should always be called immediately
     when subclassing.
     */
    open func prepare() {
        backgroundColor = .white
        contentScaleFactor = Screen.scale
        register(CollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(CollectionViewCell.self))
    }
}
