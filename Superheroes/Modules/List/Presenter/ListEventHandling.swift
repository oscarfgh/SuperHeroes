//
//  ListEventHandling.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

protocol ListEventHandling: Presenting {
    
    func pressCell(withIndex index: Int)
    func prepareDetailViewController(_ viewController: DetailViewController, superheroe: Superheroe)
    func removeDetailViewController()
    func retryLoadData()
}
