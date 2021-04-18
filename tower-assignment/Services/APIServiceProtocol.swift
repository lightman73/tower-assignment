//
//  APIServiceProtocol.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation


public enum APIServiceError: LocalizedError {
    case serverError(Int?, String?, Error)          // http status code, error description, error from server
    case dataConversionError
    case missingData
}


public protocol APIService: class {
    func getCommitsList(handler: @escaping (Result<[Commit], APIServiceError>) -> Void)
    func getChangesetFrom(commitHash: String, handler: @escaping (Result<[ChangesetEntry], APIServiceError>) -> Void)
    func getDiffFor(commitHash: String, filename: String, handler: @escaping (Result<String?, APIServiceError>) -> Void)
}
