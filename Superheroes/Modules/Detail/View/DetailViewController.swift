//
//  DetailViewController.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, SegueHandlerTypeProtocol {

    enum SegueIdentifier: String {
        case segueIdentifier = "segueIdentifier"
    }

    var eventHandler: DetailEventHandling?

    override func viewDidLoad() {

        super.viewDidLoad()

        eventHandler?.viewDidLoad()
    }

    deinit {
        print("Bye DetailViewController!")
    }
}

extension DetailViewController: DetailViewing {

}
