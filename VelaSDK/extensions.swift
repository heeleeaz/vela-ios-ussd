//
//  extensions.swift
//  VelaSDK
//
//  Created by Igbalajobi Elias on 1/15/19.
//  Copyright © 2019 Igbalajobi Elias. All rights reserved.
//

import Foundation

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}


extension Date{
    static var timeInMilli: Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
}
