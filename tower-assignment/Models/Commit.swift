//
//  Commit.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import UIKit

public struct Commit: Codable {
    public var hash: String
    public var authorName: String
    public var authorEmail: String
    public var subject: String
    public var date: Date
    
    // Computed properties
    public var avatar: UIImage? {
        // TODO: add avatar retrieval from Gravatar
        return nil
    }
}
