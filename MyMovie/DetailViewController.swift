//
//  DetailViewController.swift
//  MyMovie
//
//  Created by Hung Nguyen on 10/14/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit
import AFNetworking
class DetailViewController: UIViewController {

    @IBOutlet weak var overviewMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    var movie = Class_Movie()
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }

    private func initLayout(){
        self.imageDetail.setImageWith(URL(string: movie.imageUrl)!)
        titleMovie.text = movie.title
        overviewMovie.text = movie.overview
        dateMovie.text = movie.date
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

