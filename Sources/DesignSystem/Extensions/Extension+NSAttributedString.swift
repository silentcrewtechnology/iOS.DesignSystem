//
//  File.swift
//  
//
//  Created by firdavs on 01.06.2023.
//

import UIKit

extension NSAttributedString {
    
    func fullRange() -> NSRange {
        let nsString = self.string as NSString
        return nsString.range(of: self.string)
    }
    
    func stringRange(with string: String) -> NSRange {
        let result = self.string as NSString
        return result.range(of: string)
    }
    
    func applyColor(_ color: UIColor) -> NSAttributedString {
        if let result = self.mutableCopy() as? NSMutableAttributedString {
            result.addAttributes([.foregroundColor: color], range: fullRange())
            return (result.copy() as? NSAttributedString) ?? self
        }
        return self
    }
}
