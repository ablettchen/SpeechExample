//
//  Beile+UIButton.swift
//  BestLe
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

public extension UIButton {
    /// Convenience way to change titleLabel font size.
    var fontSize: CGFloat {
        get {
            return titleLabel?.font?.pointSize ?? UIFont.buttonFontSize
        }
        set(value) {
            titleLabel?.font = titleLabel?.font?.withSize(value) ?? UIFont.systemFont(ofSize: value)
        }
    }
}
