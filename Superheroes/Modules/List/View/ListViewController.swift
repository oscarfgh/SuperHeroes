//
//  ListViewController.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController, SegueHandlerTypeProtocol {

    enum SegueIdentifier: String {
        case segueIdentifier = "segueIdentifier"
    }

    var eventHandler: ListEventHandling?

    override func viewDidLoad() {

        super.viewDidLoad()

        eventHandler?.viewDidLoad()
    }

    deinit {
        print("Bye ListViewController!")
    }
}

extension ListViewController: ListViewing {

}
