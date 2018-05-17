//
//  AcceptanceTestCase.swift
//  SuperheroesTests
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import KIF

@testable import Superheroes

class AcceptanceTestCase: KIFTestCase {
    
    fileprivate var originalRootViewController: UIViewController?
    fileprivate var rootViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set(newRootViewController) {
            UIApplication.shared.keyWindow?.rootViewController = newRootViewController
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        if let originalRootViewController = originalRootViewController {
            rootViewController = originalRootViewController
        }
    }
    
    // MARK: - Private
    
    func openViewController(_ navigationBarHidden: Bool = true) {
        let viewController = wireUpModule()
        let rootViewController = UINavigationController()
        rootViewController.isNavigationBarHidden = navigationBarHidden
        rootViewController.viewControllers = [viewController]
        present(viewController: rootViewController)
    }
    
    func wireUpModule() -> UIViewController {
        fatalError("wireUpModule should be overriden")
    }
    
    func present(viewController: UIViewController) {
        originalRootViewController = rootViewController
        rootViewController = viewController
    }
    
    func createCodeableFromFile<T:Codable>(named filename: String) -> T? {
        let decoder = JSONDecoder()
        
        let testBundle = Bundle(for: type(of: self))
        
        guard
            let filePath = testBundle.path(forResource: filename, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: []),
            let object = try? decoder.decode(T.self, from: data)
            else {
                print("\(filename).json not found")
                return nil
        }
        return object
    }
    
    func createBodyData<T:Codable>(from object: T) -> Data? {
        guard
            let body = try? JSONEncoder().encode(object) else {
                print("creating body")
                return nil
        }
        return body
    }
}
