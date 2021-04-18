//
//  Date+Formatted.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation

extension Date {
    var formattedDate: String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    var formattedShortDate: String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}
