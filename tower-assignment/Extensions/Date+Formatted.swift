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
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: self)
    }

    var formattedShortDate: String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
    
    var formattedDateTime: String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
