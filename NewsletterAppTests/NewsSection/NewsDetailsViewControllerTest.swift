//
//  NewsDetailsViewControllerTest.swift
//  NewsletterAppTests
//
//  Created by Flaminia Castaño on 26/12/2023.
//

import XCTest
import SnapshotTesting
@testable import NewsletterApp

class NewsDetailsViewControllerTest: XCTestCase {

    func testNewsDetailsViewController() {
        //isRecording = true
        let view = NewsDetailViewController()
        let viewModel = createNewModel()
        view.selectedNews = viewModel
        view.thumbnailImageView.image = UIImage(systemName: "person")
        

        assertSnapshot(matching: view, as: .image)
    }
    
    func testCustomizeViewWithViewModel() {
        let view = NewsDetailViewController()
        let viewModel = createNewModel()
        
        view.customizeViewWithViewModel(viewModel: viewModel)
        
        XCTAssertEqual(view.titleLabel.text, "Lorem Ipsum")
        XCTAssertEqual(view.contentLabel.text, "Some content")
        XCTAssertEqual(view.publishedAtLabel.text, "Fecha de publicación: 01/01/2023")
    }
    
    private func createNewModel() -> NewModel {
        return NewModel(id: 1, slug: "lorem-ipsum", url: "https://example.com", title: "Lorem Ipsum", content: "Some content", image: "https://example.com/image.jpg", thumbnail: "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org", status: .published, category: .lorem, publishedAt: "01/01/2023", updatedAt: "02/01/2023", userID: 1)
    }
}
