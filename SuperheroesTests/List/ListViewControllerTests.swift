//
//  ListViewControllerTests.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import XCTest
import KIF
import Nimble
import UIKit
import Result

@testable import Superheroes

class ListViewControllerTests: AcceptanceTestCase {
    
    var sut: ListViewController!
    var eventHandler: ListEventHandlerMock!
    
    var mockSuperheroesRepository = MockSuperheroesRepository()

    override func setUp() {
        super.setUp()
        
        mockSuperheroesRepository.superheroesResult = Result(value: superheroes)
        
        createSut()
    }
    
    func createSut() {
        sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        eventHandler = ListEventHandlerMock()
        sut.eventHandler = eventHandler
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
    
    func testEventHandlerIsPersisted() {
        guard
            let eventHandlerSut = sut.eventHandler as? ListEventHandlerMock else {
                XCTFail("Event handler missing")
                fatalError("Event handler missing")
        }
        XCTAssertTrue(eventHandlerSut === eventHandler,
                      "Event handler must be persisted when the property is set.")
    }
    
    func testViewDidLoadInvokesEventHandler() {
        _ = sut.view
        XCTAssertTrue(eventHandler.viewDidLoadWasInvoked,
                      "View did load must trigger an event in the event handler.")
    }
    
    // MARK: - Acceptance Tests
    
    func testShowListViewController() {
        openViewController()
        
        tester().waitForView(withAccessibilityLabel: "list_view")
        
    }
    
    func testShowTableViewWithNumberOfSectionAndRowsIsCorrect() {
        openViewController()
        
        XCTAssertEqual(tableView.numberOfSections, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 6)
    }
    
    func testShowFirstCellInListViewController() {
        openViewController()
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        tester().waitForCell(at: indexPath, in: tableView)
        tester().waitForView(withAccessibilityLabel: "Spiderman")
    }
    
    func testScrollAndShowLastCellInListViewController() {
        openViewController()
        
        scrollTableView()
        
        let indexPath = IndexPath(row: 5, section: 0)
        
        tester().waitForCell(at: indexPath, in: tableView)
        tester().waitForView(withAccessibilityLabel: "Captain America")
    }
    
    func testShowAlertViewInListViewController() {
        mockSuperheroesRepository.superheroesResult = Result(error: APIClientError.httpClientError(error: NSError.networkError()))
        
        tester().waitForAnimationsToFinish()
        openViewController()
        
        tester().waitForView(withAccessibilityLabel: "Fallo de conexión")
    }
    
    func testShowAlertViewAndPressRetryInListViewController() {
        mockSuperheroesRepository.superheroesResult = Result(error: APIClientError.httpClientError(error: NSError.networkError()))
        
        tester().waitForAnimationsToFinish()
        openViewController()
        
        mockSuperheroesRepository.superheroesResult = Result(value: superheroes)
        
        tester().waitForView(withAccessibilityLabel: "Fallo de conexión")
        tester().tapView(withAccessibilityLabel: "Reintentar")
        tester().waitForView(withAccessibilityLabel: "Spiderman")
    }
    
    func testTapOnCellAndNavigate() {
        openViewController()
        
        let indexPath = IndexPath(row: 0, section: 0)
        tester().tapRow(at: indexPath, in: tableView)
        
        tester().waitForView(withAccessibilityLabel: "detail_view")
    }

    
    // MARK: - Private
    
    override func wireUpModule() -> ListViewController {
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        let dependencies = ListInteractorDependencies(superheroesRepository: mockSuperheroesRepository)
        let interactor = ListInteractor(dependencies: dependencies)
        let presenter = ListPresenter(interactor: interactor)
        
        viewController.eventHandler = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    private var tableView: UITableView {
        let accessibilityLabel = "list_tableview"
        guard let tableView: UITableView = tester().waitForView(withAccessibilityLabel: accessibilityLabel) as? UITableView else {
            fatalError("TableView is needed!")
        }
        
        return tableView
    }
    
    private var superheroes: Superheroes {
        guard let superheroes: Superheroes = createCodeableFromFile(named: "response") else {
            fatalError("Parsing Error")
        }
        
        return superheroes
    }
    
    private func scrollTableView() {
        tester().scroll(UIAccessibilityElement(accessibilityContainer: tableView), in: tableView, byFractionOfSizeHorizontal: 0, vertical: -0.1)
    }
    
    // MARK: - Mocks and Stubs
    
    class ListEventHandlerMock: ListEventHandling {
        
        var viewDidLoadWasInvoked = false
        
        func viewDidLoad() {
            viewDidLoadWasInvoked = true
        }
    }
}
