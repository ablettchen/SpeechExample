//
//  Beile+UIWindow.swift
//  BestLe
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

extension UIWindow {
    /**
     Captures a screenshot of the contents in the apps keyWindow.
     - Returns: An optional UIImage.
     */
    open func capture() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, isOpaque, Screen.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
