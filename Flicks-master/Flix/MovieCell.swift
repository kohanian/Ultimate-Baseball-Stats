//
//  MovieCell.swift
//  Flix
//
//  Created by Rohan Gupta on 1/14/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            let title = movie.title
            let overview = movie.overview
            
            titleLabel.text = title
            overviewLabel.text = overview
            posterImageView.af_setImage(withURL: movie.posterUrl!)
        
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
