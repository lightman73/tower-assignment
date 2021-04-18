//
//  String+Date.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation

extension String {
    var iso8601StringToDate: Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        return dateFormatter.date(from: self)
    }
}
