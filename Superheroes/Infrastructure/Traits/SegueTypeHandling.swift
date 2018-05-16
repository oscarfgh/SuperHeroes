//
//  SegueTypeHandling.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import UIKit

protocol SegueHandlerTypeProtocol {
    
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerTypeProtocol where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegueWithIdentifier(_ segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(_ segue: UIStoryboardSegue) -> SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else {
                fatalError("Invalid segue identifier \(String(describing: segue.identifier)).")
        }
        return segueIdentifier
    }
}
