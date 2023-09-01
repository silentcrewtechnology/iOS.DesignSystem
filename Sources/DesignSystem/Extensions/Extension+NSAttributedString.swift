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
    
    func range(of string: String) -> NSRange {
        let result = self.string as NSString
        return result.range(of: string)
    }
}
