//
//  DetailPresenter.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

class DetailPresenter {

    weak var view: DetailViewing?
    var connector: DetailConnector?
    let superheroe: Superheroe
    
    init(superheroe: Superheroe) {
        self.superheroe = superheroe
    }
    
    deinit {
        print("Bye DetailPresenter!")
    }
}

extension DetailPresenter: Presenting {

    func viewDidLoad() {
        print("Detail")
        
        view?.configureUI(superheroe: superheroe)
    }
}
