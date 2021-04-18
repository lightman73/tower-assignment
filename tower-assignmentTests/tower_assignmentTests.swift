//
//  tower_assignmentTests.swift
//  tower-assignmentTests
//
//  Created by Francesco Marini on 18/04/21.
//

import XCTest
@testable import tower_assignment

class tower_assignmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testISO8601Extensions() {
        let stringDate = "2021-04-18T18:27:32Z"
        let convertedDate = stringDate.iso8601StringToDate
        
        XCTAssertFalse(convertedDate == nil)
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        let dateBackToString = dateFormatter.string(from: convertedDate ?? Date())
        
        XCTAssert(dateBackToString == stringDate)
    }
    
    func testCommitInitializesCorrectly() {
        let commit = Commit(hash: "ec0f93a", authorName: "Jon Snow", authorEmail: "jon.snow@stark.com", subject: "Just a test commit", date: "2021-04-18T18:27:32Z".iso8601StringToDate ?? Date(timeIntervalSince1970: 0))
        
        XCTAssert(commit.hash == "ec0f93a")
        XCTAssert(commit.authorName == "Jon Snow")
        XCTAssert(commit.authorEmail == "jon.snow@stark.com")
        XCTAssert(commit.subject == "Just a test commit")
        XCTAssertFalse(commit.date == Date(timeIntervalSince1970: 0))
    }
    
    func testChangesetEntryInitializesCorrectly() {
        let changesetEntry = ChangesetEntry(status: .added, filename: "test")
        
        XCTAssert(changesetEntry.status == .added)
        XCTAssert(changesetEntry.filename == "test")
    }
    
    func testMockAPIService() {
        let mockAPIService = MockAPIService()
        
        let testCommmit = Commit(hash: "ec0f93a", authorName: "Jon Snow", authorEmail: "jon.snow@stark.com", subject: "Just a test commit", date: "2021-04-18T18:27:32Z".iso8601StringToDate ?? Date(timeIntervalSince1970: 0))
        
        mockAPIService.getCommitsList() { result in
            switch result {
            case .success(let commits):
                XCTAssertFalse(commits.count == 0)
                XCTAssert(commits[0] == testCommmit)
            case .failure(_):
                break
            }
        }
        
        // The same could be done for the other mocked calls
    }
}
