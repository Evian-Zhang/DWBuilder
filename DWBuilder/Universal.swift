//
//  Universal.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/12.
//

import Foundation

class UniversalDateFormatter {
    static let instance = createInstance()
    
    private class func createInstance() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.calendar = .current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        return dateFormatter
    }
}

class UniversalLatitudeFormatter {
    static let instance = createInstance()
    
    private class func createInstance() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.allowsFloats = true
        formatter.minimum = 0.0
        formatter.maximum = 90.0
        
        return formatter
    }
}
