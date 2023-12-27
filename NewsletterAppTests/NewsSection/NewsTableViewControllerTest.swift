//
//  NewsTableViewControllerTest.swift
//  NewsletterAppTests
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import XCTest
import SnapshotTesting
@testable import NewsletterApp

class NewsTableViewControllerTest: XCTestCase {
    var viewController: NewsTableViewController!

    override func setUp() {
        super.setUp()
        viewController = NewsTableViewController()
        viewController.newsNotes = createNewsModels()
        viewController.loadViewIfNeeded()
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.newsTableView.dataSource, "Tabla debe tener un origen de datos")
        XCTAssertTrue(viewController.newsTableView.dataSource is NewsTableViewController)
        }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewController.newsTableView.delegate, "Tabla debe tener un delegado")
        XCTAssertTrue(viewController.newsTableView.delegate is NewsTableViewController)
    }
    
    func testTableViewNumberOfRowsInSection() {
        let numberOfRows = viewController.tableView(viewController.newsTableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, viewController.newsNotes.count, "El número de filas debe ser igual al número de modelos de noticias")
    }
    
    func testNewsTableViewControllerTest() {
        //isRecording = true
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testSearchResults() {
        viewController.newsViewModel.delegate = viewController
        viewController.searchController.isActive = true
        viewController.searchController.searchBar.text = "Dolor"

        let searchExpectation = XCTestExpectation(description: "Search results updated")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                searchExpectation.fulfill()
        }
        wait(for: [searchExpectation], timeout: 5.0)

        XCTAssertEqual(viewController.filteredNews.count, 1)
        XCTAssertEqual(viewController.filteredNews.first?.title, "Dolor Sit Amet")
    }

    
    private func createNewsModels() -> [NewModel] {
        let news1 = NewModel(id: 1, slug: "lorem-ipsum", url: "https://example.com", title: "Lorem Ipsum", content: "Some content", image: "https://example.com/image.jpg", thumbnail: "https://example.com/thumbnail.jpg", status: .published, category: .lorem, publishedAt: "01/01/2023", updatedAt: "02/01/2023", userID: 1)

        let news2 = NewModel(id: 2, slug: "dolor-sit-amet", url: "https://example.com", title: "Dolor Sit Amet", content: "More content", image: "https://example.com/image2.jpg", thumbnail: "https://example.com/thumbnail2.jpg", status: .published, category: .ipsum, publishedAt: "02/01/2023", updatedAt: "03/01/2023", userID: 2)

        let news3 = NewModel(id: 3, slug: "consectetur-adipiscing", url: "https://example.com", title: "Consectetur Adipiscing", content: "Even more content", image: "https://example.com/image3.jpg", thumbnail: "https://example.com/thumbnail3.jpg", status: .published, category: .rutrum, publishedAt: "03/01/2023", updatedAt: "04/01/2023", userID: 3)
        return [news1, news2, news3]
    }
}
