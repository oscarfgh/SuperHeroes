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
        case showDetailView = "showDetailView"
    }

    let textCellIdentifier = "Cell"
    var eventHandler: ListEventHandling?
    var superheroes: [Superheroe]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        super.viewDidLoad()

        eventHandler?.viewDidLoad()
    }

    deinit {
        print("Bye ListViewController!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueIdentifier = segueIdentifierForSegue(segue)
        
        switch segueIdentifier {
        case .showDetailView:
            break
        }
    }
}

extension ListViewController: ListViewing {
    
    func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadData(data: [Superheroe]) {
        superheroes = data
        tableView.reloadData()
    }
    
    func presentView(forCell index: Int) {
        performSegueWithIdentifier(.showDetailView, sender: self)
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = superheroes?[indexPath.row].name
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler?.pressCell(withIndex: indexPath.row)
    }
}

