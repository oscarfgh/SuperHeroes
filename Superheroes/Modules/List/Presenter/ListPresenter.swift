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
    var superheroes: [Superheroe] = []

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
        loadData()
    }
    
    func loadData() {
        view?.showLoadingView()
        interactor.superheroes { (result: Result<Superheroes, APIClientError>) in
            self.view?.hideLoadingView()
            switch result {
            case .failure(let error):
                self.view?.showError(error: error)
            case .success(let data):
                self.superheroes = data.superheroes
                let dataModel: [DataModel] = self.superheroes.map { DataModel(title: $0.name, urlImage: $0.photo) }
                self.view?.reloadData(data: dataModel)
            }
        }
    }
}

extension ListPresenter: ListEventHandling {
    
    func retryLoadData() {
        loadData()
    }
    
    func pressCell(withIndex index: Int) {
        let superheroe = superheroes[index]
        view?.presentView(withSuperheroe: superheroe)
    }
    
    func prepareDetailViewController(_ viewController: DetailViewController, superheroe: Superheroe) {
        connector?.initializeDetailModule(viewController, superheroe: superheroe)
    }
    
    func removeDetailViewController() {
        connector?.deinitializeDetailModule()
    }
}
