//
//  DetailViewControllerTests.swift
//  DigioStoreTests
//
//  Created by Erick Fernandes Batista on 19/08/24.
//

import XCTest
@testable import DigioStore

class DetailViewControllerTests: XCTestCase {

    var detailViewController: DetailViewController!
    var detailModel: DetailModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        detailModel = DetailModel(name: "Test Product",
                                  imageUrl: "https://example.com/test-image.png",
                                  description: "This is a test product description.")

        detailViewController = DetailViewController(detailModel: detailModel)

        _ = detailViewController.view
    }

    override func tearDownWithError() throws {
        detailViewController = nil
        detailModel = nil
        try super.tearDownWithError()
    }

    func testViewControllerInitialization() {
        XCTAssertNotNil(detailViewController)
        XCTAssertEqual(detailViewController.detailModel.name, detailModel.name)
        XCTAssertEqual(detailViewController.detailModel.imageUrl, detailModel.imageUrl)
        XCTAssertEqual(detailViewController.detailModel.description, detailModel.description)
    }

    func testUIElementsSetup() {
        XCTAssertEqual(detailViewController.nameLabel.text, detailModel.name)
        XCTAssertEqual(detailViewController.descriptionLabel.text, detailModel.description)
    }

    func testImageViewLoading() {
        let expectedImageUrl = URL(string: detailModel.imageUrl)
        XCTAssertNotNil(expectedImageUrl)
    }
}
