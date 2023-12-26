//
//  NewsTableViewCellTests.swift
//  NewsletterAppTests
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import XCTest
import SnapshotTesting
@testable import NewsletterApp

class NewsTableViewCellTests: XCTestCase {

    func testNewsTableViewCell() {
        //isRecording = true
        let cell = NewsTableViewCell(style: .default, reuseIdentifier: NewsTableViewCell.reuseIdentifier)
        let news = createNewModel()
        cell.configure(with: news)
        

        assertSnapshot(matching: cell, as: .image)
    }
    
    func testConfigure() {
        let cell = NewsTableViewCell(style: .default, reuseIdentifier: NewsTableViewCell.reuseIdentifier)
        let news = createNewModel()
        cell.configure(with: news)
        
        XCTAssertEqual(cell.titleLabel.text, "Lorem Ipsum")
        XCTAssertEqual(cell.contentLabel.text, "Some content")
    }
    
    private func createNewModel() -> NewModel {
        return NewModel(id: 1, slug: "lorem-ipsum", url: "https://example.com", title: "Lorem Ipsum", content: "Some content", image: "https://example.com/image.jpg", thumbnail: "https://example.com/thumbnail.jpg", status: .published, category: .lorem, publishedAt: "01/01/2023", updatedAt: "02/01/2023", userID: 1)
    }
}
