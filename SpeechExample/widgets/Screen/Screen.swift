//
//  Screen.swift
//  BestLe
//
//  Created by ablett on 2019/7/7.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public struct Screen {
    /// Retrieves the device bounds.
    public static var bounds: CGRect {
        return UIScreen.main.bounds
    }
    
    /// Retrieves the device width.
    public static var width: CGFloat {
        return bounds.width
    }
    
    /// Retrieves the device height.
    public static var height: CGFloat {
        return bounds.height
    }
    
    /// Retrieves the device scale.
    public static var scale: CGFloat {
        return UIScreen.main.scale
    }
}

