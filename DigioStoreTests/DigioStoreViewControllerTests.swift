//
//  DigioStoreTests.swift
//  DigioStoreTests
//
//  Created by Erick Fernandes Batista on 16/08/24.
//

import XCTest
@testable import DigioStore

class DigioStoreViewControllerTests: XCTestCase {

    var viewController: DigioStoreViewController!
    var mockService: MockDigioStoreService!

    override func setUpWithError() throws {
        try super.setUpWithError()

        viewController = DigioStoreViewController()
        mockService = MockDigioStoreService()
        viewController.digioStoreService = mockService

        _ = viewController.view
    }

    override func tearDownWithError() throws {
        viewController = nil
        mockService = nil
        try super.tearDownWithError()
    }

    func testNumberOfSections() {
        XCTAssertEqual(viewController.numberOfSections(in: viewController.tableView), 4)
    }

    func testNumberOfRowsInSection() {
        for section in 0..<4 {
            XCTAssertEqual(viewController.tableView(viewController.tableView, numberOfRowsInSection: section), 1)
        }
    }

    func testFetchDataSuccess() {
        let expectation = self.expectation(description: "Dados carregados")
        if let mockData = loadDigioStoreFromJSON() {
            mockService.result = .success(mockData)
            viewController.fetchData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertNotNil(self.viewController.storeData,
                                "storeData deveria ter sido preenchido, mas está nil")
                XCTAssertEqual(self.viewController.storeData?.spotlight.count, 2,
                               "A quantidade de itens no spotlight deveria ser 2")
                XCTAssertEqual(self.viewController.storeData?.products.count, 3,
                               "A quantidade de itens em products deveria ser 3")
                expectation.fulfill()
            }
        } else {
            XCTFail("Falha ao carregar os dados do JSON")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchDataFailure() {
        mockService.result = .failure(NSError(domain: "", code: 0, userInfo: nil))
        viewController.fetchData()
        XCTAssertNil(viewController.storeData)
    }

    func testCellForRowAt() {
        guard let mockData = loadDigioStoreFromJSON() else {
            XCTFail("Falha ao carregar os dados do JSON")
            return
        }

        let expectation = self.expectation(description: "Dados carregados")

        mockService.result = .success(mockData)
        viewController.fetchData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let indexPath1 = IndexPath(row: 0, section: 0)
            let cell1 = self.viewController.tableView(self.viewController.tableView, cellForRowAt: indexPath1)
            XCTAssertTrue(cell1 is UserHeaderCell)

            let indexPath2 = IndexPath(row: 0, section: 1)
            let cell2 = self.viewController.tableView(self.viewController.tableView, cellForRowAt: indexPath2)
            XCTAssertTrue(cell2 is SpotlightCell)

            if let spotlightCell = cell2 as? SpotlightCell {
                XCTAssertEqual(spotlightCell.spotlightItems.count, mockData.spotlight.count)
            } else {
                XCTFail("Falha ao cast SpotlightCell")
            }

            let indexPath3 = IndexPath(row: 0, section: 2)
            let cell3 = self.viewController.tableView(self.viewController.tableView, cellForRowAt: indexPath3)
            XCTAssertTrue(cell3 is CashCell)

            if let cashCell = cell3 as? CashCell {
                XCTAssertEqual(cashCell.cashBannerImageView.image, UIImage(named: "expectedImage"))
            } else {
                XCTFail("Falha ao cast CashCell")
            }

            let indexPath4 = IndexPath(row: 0, section: 3)
            let cell4 = self.viewController.tableView(self.viewController.tableView, cellForRowAt: indexPath4)
            XCTAssertTrue(cell4 is ProductsCell)

            if let productsCell = cell4 as? ProductsCell {
                XCTAssertEqual(productsCell.productItems.count, mockData.products.count)
            } else {
                XCTFail("Falha ao cast ProductsCell")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func loadDigioStoreFromJSON() -> DigioStore? {
        if let url = Bundle(for: type(of: self)).url(forResource: "digio", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let digioStore = try decoder.decode(DigioStore.self, from: data)
                print("Dados carregados: \(digioStore)")
                return digioStore
            } catch {
                fatalError("Erro ao carregar ou decodificar digio.json: \(error)")
            }
        } else {
            XCTFail("digio.json not found in bundle")
            return nil
        }
    }
}

class MockDigioStoreService: DigioStoreService {
    var result: Result<DigioStore, Error>?

    override func fetchStoreData(completion: @escaping (Result<DigioStore, Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
