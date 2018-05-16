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

    let cellIdentifier = String(describing: ListCell.self)
    let cellHeight: CGFloat = 200.0
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
        title = "Superheroes"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListCell else {
            fatalError("Fail create cell in List")
        }
        
        cell.titleText = superheroes?[indexPath.row].name
        cell.urlImage = superheroes?[indexPath.row].photo
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        eventHandler?.pressCell(withIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

