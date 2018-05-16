//
//  ListCell.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import UIKit
import SDWebImage

class ListCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleText: String? = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var urlImage: URL! {
        didSet {
            backgroundImageView.sd_setImage(with: urlImage, completed: nil)
        }
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        
        titleText = ""
        backgroundImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = true
    }
}
