//
//  DetailViewControllerTests.swift
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

class DetailViewControllerTests: AcceptanceTestCase {
    
    var sut: DetailViewController!
    var eventHandler: DetailEventHandlerMock!
    
    override func setUp() {
        super.setUp()
        
        createSut()
    }
    
    func createSut() {
        sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        eventHandler = DetailEventHandlerMock()
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
            let eventHandlerSut = sut.eventHandler as? DetailEventHandlerMock else {
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
    
    func testShowDetailViewController() {
        openViewController()
        
        tester().waitForView(withAccessibilityLabel: "detail_view")
    }
    
    func testShowTitleNavBar() {
        openViewController()
        
        tester().waitForView(withAccessibilityLabel: "Spiderman")
    }
    
    func testEmptyNameLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "name_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect("").to(equal(label.text))
    }
    
    func testFillRealNameLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "real_name_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect(self.superheroe.realName).to(equal(label.text))
    }
    
    func testFillHeightLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "height_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect(self.superheroe.height).to(equal(label.text))
    }
    
    func testFillPowerLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "power_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect(self.superheroe.power).to(equal(label.text))
    }
    
    func testFillAbilitiesLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "abilities_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect(self.superheroe.abilities).to(equal(label.text))
    }
    
    func testFillGroupsLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "groups_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect(self.superheroe.groups).to(equal(label.text))
    }
    
    func testFillTitlePowerLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "title_power_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect("Power").to(equal(label.text))
    }
    
    func testFillTitleAbilitiesLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "title_abilities_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect("Abilities").to(equal(label.text))
    }
    
    func testFillTitleGroupsLabel() {
        openViewController()
        
        guard let label: UILabel = tester().waitForView(withAccessibilityLabel: "title_groups_label") as? UILabel else {
            XCTFail("UILabel fail")
            return
        }
        
        expect("Groups").to(equal(label.text))
    }
    
    func testFillImageView() {
        openViewController()
        
        guard let imageview: UIImageView = tester().waitForView(withAccessibilityLabel: "imageview") as? UIImageView else {
            XCTFail("UILabel fail")
            return
        }
        
        XCTAssertNotNil(imageview.image)
    }
    
    // MARK: - Private
    
    override func wireUpModule() -> DetailViewController {
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let presenter = DetailPresenter(superheroe: superheroe)
        
        viewController.eventHandler = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    private var superheroe: Superheroe {
        guard
            let superheroes: Superheroes = createCodeableFromFile(named: "response"),
            let superheroe: Superheroe = superheroes.superheroes.first else {
                fatalError("Parsing Error")
        }
        
        return superheroe
    }
    
    // MARK: - Mocks and Stubs
    
    class DetailEventHandlerMock: Presenting {
        
        var viewDidLoadWasInvoked = false
        
        func viewDidLoad() {
            viewDidLoadWasInvoked = true
        }
    }
}
