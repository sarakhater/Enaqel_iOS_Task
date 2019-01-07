//
//  SearchTableViewCell.swift
//  EnaqelTask
//
//  Created by unitlabs on 1/4/19.
//  Copyright © 2019 BestOffer. All rights reserved.
//

import UIKit
import Cosmos

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    @IBOutlet weak var addToFavBtn: UIButton!
    @IBOutlet weak var movie_date: UILabel!
    @IBOutlet weak var movie_title: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var ratingBar: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingBar.settings.updateOnTouch = false
        
        // Show only fully filled stars
        ratingBar.settings.fillMode = .full
        // Other fill modes: .half, .precise
        
        // Change the size of the stars
        ratingBar.settings.starSize = 15
        
        
        // Set the distance between stars
        ratingBar.settings.starMargin = 5
        
        // Set the color of a filled star
        ratingBar.settings.filledColor = UIColor.orange
        
        // Set the border color of an empty star
        ratingBar.settings.emptyBorderColor = UIColor.orange
        
        // Set the border color of a filled star
        ratingBar.settings.filledBorderColor = UIColor.orange    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
