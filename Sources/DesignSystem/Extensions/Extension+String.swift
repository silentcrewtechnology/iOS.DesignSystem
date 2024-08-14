//
//  File.swift
//  
//
//  Created by firdavs on 01.06.2023.
//

import UIKit
import CryptoKit

public extension String {
    func fontStyle(_ style: FontStyle) -> NSMutableAttributedString {
        let styledString = attributed.fontStyle(style)
        return styledString
    }
}

public extension String {
    
    var sha1Base64: String {
        guard let data = data(using: .utf8) else { return "" }
        return Data(Insecure.SHA1.hash(data: data)).base64EncodedString()
    }
    
    var sha256Base64: String {
        guard let data = data(using: .utf8) else { return "" }
        return Data(SHA256.hash(data: data)).base64EncodedString()
    }
}

public extension String {

    func heading4XL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.heading4XL)
        return attributedString
    }
    
    func heading3XL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.heading3XL)
        return attributedString
    }
    
    func heading2XL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.heading2XL)
        return attributedString
    }
    
    func headingXL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.headingXL)
        return attributedString
    }
    
    
    func text4XL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text4XL)
        return attributedString
    }
    
    func text4XL_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text4XL_1)
        return attributedString
    }
    
    func text3XL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text3XL)
        return attributedString
    }
    
    func text3XL_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text3XL_1)
        return attributedString
    }
    
    func text2XL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text2XL)
        return attributedString
    }
    
    func text2XL_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text2XL_1)
        return attributedString
    }
    
    func textXL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textXL)
        return attributedString
    }
    
    func textXL_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textXL_1)
        return attributedString
    }
    
    func textL(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textL)
        return attributedString
    }
    
    func textL_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textL_1)
        return attributedString
    }
    
    func textM(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textM)
        return attributedString
    }
    
    func textM_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textM_1)
        return attributedString
    }
    
    func textS(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textS)
        return attributedString
    }
    
    func textS_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textS_1)
        return attributedString
    }
    
    func textXS(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textXS)
        return attributedString
    }
    
    func textXS_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.textXS_1)
        return attributedString
    }
    
    func text2XS(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text2XS)
        return attributedString
    }
    
    func text2XS_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text2XS_1)
        return attributedString
    }
    
    func text3XS(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text3XS)
        return attributedString
    }
    
    func text3XS_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .attributed
            .foregroundColor(color)
            .fontStyle(.text3XS_1)
        return attributedString
    }
    
    func caption3XS(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .uppercased()
            .attributed
            .foregroundColor(color)
            .fontStyle(.caption3XS)
            .kern(0.3)
        return attributedString
    }
    
    func caption3XS_1(color: UIColor) -> NSMutableAttributedString {
        let attributedString = self
            .uppercased()
            .attributed
            .foregroundColor(color)
            .fontStyle(.caption3XS_1)
            .kern(0.3)
        return attributedString
    }
}
