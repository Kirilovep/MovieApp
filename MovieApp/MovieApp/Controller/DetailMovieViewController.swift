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
    var detailCrew: [Crew] = []
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var castCollectionView: UICollectionView! {
        didSet {
            castCollectionView.delegate = self
            castCollectionView.dataSource = self
            let nib = UINib(nibName: Cells.castCollectionCellNib.rawValue, bundle: nil)
            castCollectionView.register(nib, forCellWithReuseIdentifier: Cells.castCollectionCellIdentefier.rawValue)
        }
    }
    @IBOutlet weak var crewCollectionView: UICollectionView! {
        didSet {
            crewCollectionView.delegate = self
            crewCollectionView.dataSource = self
            let crewNib = UINib(nibName: Cells.crewCollectionCellNib.rawValue, bundle: nil)
            crewCollectionView.register(crewNib, forCellWithReuseIdentifier: Cells.crewCollectionCellIdentifier.rawValue)
        }
    }
         override func viewDidLoad() {
               super.viewDidLoad()
            
        detailImageView.clipsToBounds = true
        detailImageView.layer.cornerRadius = 10
  
               
                requestDetail()
                requestCast()
                requestCrew()
               
               
           }
    //MARK:- Private func-
    private func requestCast() {
           networkManager.requestCast(detailResult?.id ?? 0) { (detailedCast) in
               DispatchQueue.main.async {
                   self.detailCast = detailedCast
                   self.castCollectionView.reloadData()
               }
           }
       }
    
    private func requestCrew() {
        networkManager.requestCrew(detailResult?.id ?? 0) { (detailedCrew) in
            DispatchQueue.main.async {
                self.detailCrew = detailedCrew
                self.crewCollectionView.reloadData()
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
                guard let url = URL(string: Urls.baseImageUrl.rawValue + posterPath) else { return}
                //self.load(url: url)
                self.detailImageView.kf.setImage(with: url)
                if self.results?.budget == 0 {
                                    self.budgetLabel.text = "No budget information"
                                } else {
                                    self.budgetLabel.text = "\(self.results!.budget)$"
                                }
                //view.backgroundColor = UIColor(patternImage: UIImage)
              self.activityIndicator.stopAnimating()
             }
         }
     }
}

    //MARK:- Configure collection view -
extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return detailCast.count
        } else {
            return detailCrew.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == castCollectionView {
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.castCollectionCellIdentefier.rawValue, for: indexPath) as! CastCollectionViewCell
            castCell.configure(detailCast[indexPath.row])
            
            return castCell
            
        } else {
            let crewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.crewCollectionCellIdentifier.rawValue, for: indexPath) as! CrewCollectionViewCell
           crewCell.configure(detailCrew[indexPath.row])
            return crewCell
        }
        
    }
    
    
}


