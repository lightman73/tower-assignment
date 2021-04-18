//
//  ChangesetEntry.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

public enum ChangesetStatus: String, Codable {
    case added = "Added"
    case modified = "Modified"
    case deleted = "Deleted"
}

public struct ChangesetEntry: Codable, Equatable {
    public var status: ChangesetStatus
    public var filename: String
}
