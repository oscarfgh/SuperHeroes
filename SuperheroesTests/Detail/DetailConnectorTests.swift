//
//  DetailConnectorTests.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import XCTest

@testable import Superheroes

class DetailConnectorTests: AcceptanceTestCase {
    
    var sut: DetailConnector!
    
    override func setUp() {
        super.setUp()
        
        createSut()
    }
    
    func createSut() {
        sut = DetailConnector()
    }
    
    override func tearDown() {
        destroySut()
        super.tearDown()
    }
    
    func destroySut() {
        sut = nil
    }
    
    // MARK: - Tests
    
    func testSutIsntNil() {
        XCTAssertNotNil(sut, "SUT must not be nil.")
    }
    
    func testWireUpPreservesView() {
        let detailViewController = wireUp()
        XCTAssertTrue(sut.view === detailViewController,
                      "View must be persisted when wiring up.")
    }
    
    func testWireUpConnectsViewWithEventHandler() {
        _ = wireUp()
        XCTAssertNotNil(sut.view.eventHandler,
                        "Main view controller must be connected with an event handler.")
    }
    
    func testWireUpConnectsPresenterWithView() {
        _ = wireUp()
        let presenter = sut.view.eventHandler as? DetailPresenter
        let view = presenter?.view as? DetailViewController
        XCTAssertEqual(view, sut.view,
                       "Presenter must be connected with the main view.")
    }
    
    func testWireUpConnectsInteractorWithThisConnector() {
        _ = wireUp()
        let presenter = sut.view.eventHandler as? DetailPresenter
        guard
            let connector = presenter?.connector,
            let sut = sut else {
                XCTFail("SUT must not be nil.")
                return
        }
        XCTAssertTrue(connector === sut,
                      "Presenter must be connected with the connector.")
    }
    
    fileprivate func wireUp() -> DetailViewController {
        let detailViewController = DetailViewController()

        guard
            let superheroes: Superheroes = createCodeableFromFile(named: "response"),
            let superheroe: Superheroe = superheroes.superheroes.first else {
                XCTFail("Parse error")
                fatalError()
        }
        
        sut.wireUp(detailViewController, superheroe: superheroe)
        
        return detailViewController
    }
}
