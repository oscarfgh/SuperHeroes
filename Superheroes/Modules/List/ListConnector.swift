//
//  ListConnector.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

class ListConnector {

    var view: ListViewController!

    func wireUp(_ viewController: ListViewController,
                interactorDependencies: ListInteractorDependencies = ListInteractorDependencies.make()) {
        let interactor = ListInteractor(dependencies: interactorDependencies)
        let presenter = ListPresenter(interactor: interactor)

        view = viewController
        view.eventHandler = presenter
        presenter.view = view
        presenter.connector = self
    }

    func untangleUp() {
        view = nil
    }

    deinit {
        print("Bye ListConnector!")
    }
}
