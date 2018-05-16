//
//  Presenting.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation

protocol Presenting {
    
    func viewDidLoad()
    func viewDidAppear()
    func viewWillAppear()
    func viewDidDisappear()
    func viewWillDisappear()
}

extension Presenting {
    
    func viewDidLoad() {}
    func viewDidAppear() {}
    func viewWillAppear() {}
    func viewDidDisappear() {}
    func viewWillDisappear() {}
}
