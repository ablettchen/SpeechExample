//
//  Beile+UILabel.swift
//  BestLe
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public extension UILabel {
    /// Convenience way to change font size.
    var fontSize: CGFloat {
        get {
            return font?.pointSize ?? UIFont.labelFontSize
        }
        set(value) {
            font = font?.withSize(value) ?? UIFont.systemFont(ofSize: value)
        }
    }
}

