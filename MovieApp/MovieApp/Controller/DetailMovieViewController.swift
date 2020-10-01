//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    var detailResult: Result?
    var resultsOfMovies: DetailList?
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.manager.requestDetailMovie(detailResult?.id ?? 0) { (details) in
            DispatchQueue.main.async {
                       self.resultsOfMovies = details
                     self.titleLabel.text = self.resultsOfMovies?.title
            }
     
        }
       
    }
    


}
