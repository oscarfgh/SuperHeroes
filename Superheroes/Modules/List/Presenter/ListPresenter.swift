//
//  ListPresenter.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

class ListPresenter {

    weak var view: ListViewing?
    var connector: ListConnector?
    let interactor: ListInteractor

    init(interactor: ListInteractor) {
        self.interactor = interactor
    }

    deinit {
        print("Bye ListPresenter!")
    }
}

extension ListPresenter: Presenting {

  func viewDidLoad() {
    print("List")
  }
}

extension ListPresenter: ListEventHandling {

}
