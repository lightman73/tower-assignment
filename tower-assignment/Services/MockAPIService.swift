//
//  MockAPIService.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation

class MockAPIService: APIService {
    func getCommitsList(handler: @escaping (Result<[Commit], APIServiceError>) -> Void) {
        let dummyCommits = [
            Commit(hash: "ec0f93a", authorName: "Jon Snow", authorEmail: "jon.snow@stark.com", subject: "Just a test commit", date: "2021-04-18T18:27:32Z".iso8601StringToDate ?? Date()),
            Commit(hash: "fd1e87c", authorName: "Tyrion Lannister", authorEmail: "tyrion@lannister.com", subject: "A much better test commit", date: "2021-04-18T19:12:41Z".iso8601StringToDate ?? Date()),
            Commit(hash: "adf2f2b4", authorName: "Daenerys Targaryen", authorEmail: "daenerys@targaryen.com", subject: "Added a couple of dragons", date: "2021-04-18T20:38:00Z".iso8601StringToDate ?? Date()),
        ]
        
        let randomWait = Double.random(in: 0.3...1.0)
        let queue = DispatchQueue(label: "networking")
        
        queue.asyncAfter(deadline: .now() + randomWait) {
            handler(.success(dummyCommits))
            // handler(.failure(.missingData))
        }
    }
    
    func getChangesetFrom(commitHash: String, handler: @escaping (Result<[ChangesetEntry], APIServiceError>) -> Void) {
        let dummyChangesetForJonSnow = [
            ChangesetEntry(status: .added, filename: "NothingImportant.jpg"),
            ChangesetEntry(status: .deleted, filename: "AWrongFile.txt"),
            ChangesetEntry(status: .modified, filename: "DaenerysDragons.txt")
        ]
        
        let dummyChangesetForTyrionLannister = [
            ChangesetEntry(status: .modified, filename: "ThisIsImportant.jpg"),
            ChangesetEntry(status: .added, filename: "HowToManageAnEmpire.txt")
        ]
        
        let dummyChangesetForDaenerys = [
            ChangesetEntry(status: .added, filename: "Dragons.jpg")
        ]
        
        let randomWait = Double.random(in: 0.3...1.0)
        let queue = DispatchQueue(label: "networking")
        
        queue.asyncAfter(deadline: .now() + randomWait) {
            switch commitHash {
            case "ec0f93a":
                handler(.success(dummyChangesetForJonSnow))
            case "fd1e87c":
                handler(.success(dummyChangesetForTyrionLannister))
            case "adf2f2b4":
                handler(.success(dummyChangesetForDaenerys))
            default:
                handler(.failure(.missingData))
            }
        
            // handler(.failure(.dataConversionError))
        }
    }
    
    func getDiffFor(commitHash: String, filename: String, handler: @escaping (Result<String?, APIServiceError>) -> Void) {
        let diffs = [
            "NothingImportant.jpg" : "A new file",
            "AWrongFile.txt" : "Scrapped this one",
            "DaenerysDragons.txt" : "RIP Rhaegal. Damn Euron.",
            "ThisIsImportant.jpg" : "Added a note to remind me to send a present to my sister",
            "HowToManageAnEmpire.txt" : "Some notes",
            "Dragons.jpg" : "Took this photo during our last holiday"
        ]
        
        let randomWait = Double.random(in: 0.3...1.0)
        let queue = DispatchQueue(label: "networking")
        
        queue.asyncAfter(deadline: .now() + randomWait) {
            handler(.success(diffs[filename]))
            // handler(.failure(.dataConversionError))
        }
    }
}
