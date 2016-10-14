//
//  MovieTableViewCell.swift
//  MyMovie
//
//  Created by Hung Nguyen on 10/12/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit
import AFNetworking
class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var classMovie: Class_Movie? {
        didSet{
            if let movie = classMovie{
                self.imgMovie.setImageWith(URL(string: movie.imageUrl)!)
                self.lblOverview.text = movie.overview
                self.titleMovie.text = movie.title
            }
        }
    }
    
}
