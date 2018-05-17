//
//  DetailViewController.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var titlePowerLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var titleAbilitiesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var titleGroupsLabel: UILabel!
    @IBOutlet weak var groupsLabel: UILabel!
    
    var eventHandler: Presenting?

    override func viewDidLoad() {

        super.viewDidLoad()

        eventHandler?.viewDidLoad()
    }

    deinit {
        print("Bye DetailViewController!")
    }
}

extension DetailViewController: DetailViewing {
    
    func configureUI(superheroe: Superheroe) {
        view.backgroundColor = Color.black
        scrollView.backgroundColor = Color.black
        title = superheroe.name
        imageView.sd_setImage(with: superheroe.photo, completed: nil)
        nameLabel.text = ""
        realNameLabel.text = superheroe.realName
        heightLabel.text = superheroe.height
        titlePowerLabel.text = NSLocalizedString("power_title_key", comment: "")
        powerLabel.text = superheroe.power
        titleAbilitiesLabel.text = NSLocalizedString("abilities_title_key", comment: "")
        abilitiesLabel.text = superheroe.abilities
        titleGroupsLabel.text = NSLocalizedString("groups_title_key", comment: "")
        groupsLabel.text = superheroe.groups
    }
}
