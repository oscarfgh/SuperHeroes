//
//  DetailConnector.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

class DetailConnector {

    var view: DetailViewController!

    func wireUp(_ viewController: DetailViewController, superheroe: Superheroe) {
        let presenter = DetailPresenter()

        view = viewController
        view.eventHandler = presenter
        presenter.view = view
        presenter.connector = self
    }

    func untangleUp() {
        view = nil
    }

    deinit {
        print("Bye DetailConnector!")
    }
}
