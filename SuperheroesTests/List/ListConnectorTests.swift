//
//  ListConnectorTests.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import XCTest

@testable import Superheroes

class ListConnectorTests: XCTestCase {
    
    var sut: ListConnector!
    
    override func setUp() {
        super.setUp()
        
        createSut()
    }
    
    func createSut() {
        sut = ListConnector()
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
        let listViewController = wireUp()
        XCTAssertTrue(sut.view === listViewController,
                      "View must be persisted when wiring up.")
    }
    
    func testWireUpConnectsViewWithEventHandler() {
        _ = wireUp()
        XCTAssertNotNil(sut.view.eventHandler,
                        "Main view controller must be connected with an event handler.")
    }
    
    func testWireUpConnectsPresenterWithView() {
        _ = wireUp()
        let presenter = sut.view.eventHandler as? ListPresenter
        let view = presenter?.view as? ListViewController
        XCTAssertEqual(view, sut.view,
                       "Presenter must be connected with the main view.")
    }
    
    func testWireUpConnectsPresenterWithInteractor() {
        _ = wireUp()
        let presenter = sut.view.eventHandler as? ListPresenter
        XCTAssertNotNil(presenter?.interactor,
                        "Presenter must be connected with the interactor.")
    }
    
    func testWireUpConnectsInteractorWithThisConnector() {
        _ = wireUp()
        let presenter = sut.view.eventHandler as? ListPresenter
        guard
            let connector = presenter?.connector,
            let sut = sut else {
                XCTFail("SUT must not be nil.")
                return
        }
        XCTAssertTrue(connector === sut,
                      "Presenter must be connected with the connector.")
    }
    
    fileprivate func wireUp() -> ListViewController {
        let listViewController = ListViewController()
        let interactorDependencies = ListInteractorDependencies(
            superheroesRepository: MockSuperheroesRepository()
        )
        sut.wireUp(listViewController, interactorDependencies: interactorDependencies)
        
        return listViewController
    }
}
