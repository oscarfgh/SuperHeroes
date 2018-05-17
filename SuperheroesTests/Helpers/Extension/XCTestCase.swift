//
//  XCTestCase.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import KIF

extension XCTestCase {
    
    func tester(_ file: String = #file, line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(_ file: String = #file, line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
