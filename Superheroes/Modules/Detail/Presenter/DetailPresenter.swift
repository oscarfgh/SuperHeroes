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

  deinit {
    print("Bye DetailPresenter!")
  }
}

extension DetailPresenter: Presenting {

  func viewDidLoad() {
    print("Detail")
  }
}

extension DetailPresenter: DetailEventHandling {

}
