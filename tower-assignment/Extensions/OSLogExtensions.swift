//
//  OSLogExtensions.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation
import os

extension OSLog {
    private static var logSubsystem = Bundle.main.bundleIdentifier!
    
    static let network = OSLog(subsystem: logSubsystem, category: "Network")
    static let ui = OSLog(subsystem: logSubsystem, category: "UI")
    static let tables = OSLog(subsystem: logSubsystem, category: "tables")
}
