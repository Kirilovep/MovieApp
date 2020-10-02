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
    var results: DetailList?
    let networkManager = NetworkManager()
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var detailCollectionView: UICollectionView! {
        didSet {
            detailCollectionView.delegate = self
            detailCollectionView.dataSource = self
            
            let nib = UINib(nibName: Cells.collectionCellNib.rawValue, bundle: nil)
            detailCollectionView.register(nib, forCellWithReuseIdentifier: Cells.collectionCellIdentefier.rawValue)
        }
    }
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
         override func viewDidLoad() {
               super.viewDidLoad()

               guard let id = detailResult?.id else { return }
               print(id)
               detailImageView.clipsToBounds = true
               detailImageView.layer.cornerRadius = 10
  
               networkManager.requestDetailMovie(id) { (detailedMovie) in
                   DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                    self.results = detailedMovie
                    self.titleLabel.text = self.results?.title
                    self.voteAverageLabel.text = String(self.results!.voteAverage)
                    self.dateLabel.text = self.results?.releaseDate
                    self.overviewLabel.text = self.results?.overview
                    self.budgetLabel.text = "\(self.results?.budget ?? 0)"
                    guard let posterPath = self.results?.backdropPath else { return }
                    let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                    self.detailImageView.kf.setImage(with: url)
                    self.activityIndicator.stopAnimating()
                   }
               }
               
             
               
           }
        

        
    }


extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.collectionCellIdentefier.rawValue, for: indexPath)
        return cell
    }
    
    
}
