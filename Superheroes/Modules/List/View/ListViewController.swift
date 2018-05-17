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
        case showDetailView
        case closeDetailView
    }

    let cellIdentifier = String(describing: ListCell.self)
    let cellHeight: CGFloat = 200.0
    var eventHandler: ListEventHandling?
    var data: [DataModel]!
    var selectSuperheroe: Superheroe!
    
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
            guard
                let viewController = segue.destination as? DetailViewController else {
                    print("Not get DetailViewController")
                    return
            }

            eventHandler?.prepareDetailViewController(viewController, superheroe: selectSuperheroe)
        default:
            break
        }
    }
    
    @IBAction func unwindToList(segue:UIStoryboardSegue) {
        let segueIdentifier = segueIdentifierForSegue(segue)
        
        switch segueIdentifier {
        case .closeDetailView:
            eventHandler?.removeDetailViewController()
        default:
            break
        }
    }
}

extension ListViewController: ListViewing {
    
    func showError(error: APIClientError) {
        AlertView().showErrorView {_ in
            AlertView().hide()
            self.eventHandler?.retryLoadData()
        }
    }
    
    func configureUI() {
        title = NSLocalizedString("title_navbar_key", comment: "")
        view.backgroundColor = Color.black
        tableView.backgroundColor = Color.black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func reloadData(data: [DataModel]) {
        self.data = data
        tableView.reloadData()
    }
    
    func presentView(withSuperheroe superheroe: Superheroe) {
        selectSuperheroe = superheroe
        performSegueWithIdentifier(.showDetailView, sender: self)
    }
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListCell else {
            fatalError("Fail create cell in List")
        }
        
        cell.titleText = data?[indexPath.row].title
        cell.urlImage = data?[indexPath.row].urlImage
        
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

