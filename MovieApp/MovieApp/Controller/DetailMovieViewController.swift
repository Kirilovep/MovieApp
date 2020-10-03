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
    var detailCast: [Cast] = []
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
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

        detailImageView.clipsToBounds = true
        detailImageView.layer.cornerRadius = 10
  
            
               requestDetail()
               requestCast()
             
               
           }
    //MARK:- Private func-
    private func requestCast() {
           networkManager.requestCast(detailResult?.id ?? 0) { (detailedCast) in
               DispatchQueue.main.async {
                   self.detailCast = detailedCast
                   self.detailCollectionView.reloadData()
               }
           }
       }
    private func requestDetail() {
         networkManager.requestDetailMovie(detailResult?.id ?? 0) { (detailedMovie) in
             DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.results = detailedMovie
                self.titleLabel.text = self.results?.title
                self.voteAverageLabel.text = String(self.results!.voteAverage)
                self.dateLabel.text = self.results?.releaseDate
                self.overviewLabel.text = self.results?.overview
                guard let runTime = self.results?.runtime else { return }
                self.runTimeLabel.text = "\(runTime) minutes"
                self.languageLabel.text = self.results?.originalLanguage
                guard let posterPath = self.results?.backdropPath else { return }
                let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                self.detailImageView.kf.setImage(with: url)
                if self.results?.budget == 0 {
                                    self.budgetLabel.text = "No budget information"
                                } else {
                                    self.budgetLabel.text = "\(self.results!.budget)$"
                                }
              self.activityIndicator.stopAnimating()
             }
         }
     }
    
    }

    //MARK:- Configure collection view -
extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.collectionCellIdentefier.rawValue, for: indexPath) as! DetailCollectionViewCell
        cell.configure(detailCast[indexPath.row])
        return cell
    }
    
    
}


