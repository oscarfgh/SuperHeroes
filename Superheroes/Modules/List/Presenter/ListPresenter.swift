//
//  ListPresenter.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import Result

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
    
    view?.configureUI()
    
    interactor.superheroes { (result: Result<Superheroes, APIClientError>) in
        switch result {
        case .failure(let error):
            return
        case .success(let data):
            self.view?.reloadData(data: data.superheroes)
        }
    }
  }
}

extension ListPresenter: ListEventHandling {

    func pressCell(withIndex index: Int) {
        view?.presentView(forCell: index)
    }
}
