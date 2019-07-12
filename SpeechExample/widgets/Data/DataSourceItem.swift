//
//  DataSourceItem.swift
//  BestLe
//
//  Created by ablett on 2019/7/8.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public struct DataSourceItem {
    /// Stores an the data for the item.
    public var data: Any?
    
    /// Width for horizontal scroll direction.
    public var width: CGFloat?
    
    /// Height for vertical scroll direction.
    public var height: CGFloat?
    
    /**
     Initializer.
     - Parameter data: A reference to an Any that is associated
     with a width or height.
     - Parameter width: The width for the horizontal scroll direction.
     - Parameter height: The height for the vertical scroll direction.
     */
    public init(data: Any? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.data = data
        self.width = width
        self.height = height
    }
}
