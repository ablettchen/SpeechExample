//
//  Beile+String.swift
//  BestLe
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

extension String {
    /**
     :name:    trim
     */
    public var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /**
     :name:    lines
     */
    public var lines: [String] {
        return components(separatedBy: CharacterSet.newlines)
    }
    
    /**
     :name:    firstLine
     */
    public var firstLine: String? {
        return lines.first?.trimmed
    }
    
    /**
     :name:    lastLine
     */
    public var lastLine: String? {
        return lines.last?.trimmed
    }
    
    /**
     :name:    replaceNewLineCharater
     */
    public func replaceNewLineCharater(separator: String = " ") -> String {
        return components(separatedBy: CharacterSet.whitespaces).joined(separator: separator).trimmed
    }
    
    /**
     :name:    replacePunctuationCharacters
     */
    public func replacePunctuationCharacters(separator: String = "") -> String {
        return components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: separator).trimmed
    }
}
