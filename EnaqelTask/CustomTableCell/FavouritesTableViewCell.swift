//
//  FavouritesTableViewCell.swift
//  EnaqelTask
//
//  Created by unitlabs on 1/4/19.
//  Copyright © 2019 BestOffer. All rights reserved.
//

import UIKit
import Cosmos

class FavouritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var title_movie: UILabel!
    

    @IBOutlet weak var date_label: UILabel!
   
    
    @IBOutlet weak var ratingBar: CosmosView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
