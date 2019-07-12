//
//  Beile+UIFont.swift
//  BestLe
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//


import UIKit

extension UIFont {
    /**
     Calculates a CGSize value based on a width and length of a string with a
     given UIFont.
     - Parameter string: A String.
     - Parameter constrainedTo width: A CGFloat.
     - Returns a CGSize.
     */
    open func stringSize(string: String, constrainedTo width: CGFloat) -> CGSize {
        return string.boundingRect(with: CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude)),
                                   options: .usesLineFragmentOrigin,
                                   attributes: [.font: self],
                                   context: nil).size
    }
}
