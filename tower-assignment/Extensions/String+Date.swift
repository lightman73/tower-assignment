//
//  String+Date.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation

extension String {
    var iso8601StringToDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}
