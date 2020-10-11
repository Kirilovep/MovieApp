//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import YoutubeDirectLinkExtractor
class DetailMovieViewController: UIViewController, AVPlayerViewControllerDelegate {

    var detailResult: Result?
    var detailId: Int?
    private let extractor = LinkExtractor()
    private var results: DetailList?
    private let networkManager = NetworkManager()
    private var detailCast: [Cast] = []
    private var detailCrew: [Crew] = []
    private var videos: [Video] = []
    
    //MARK:- IBOutlets-
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
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
    @IBOutlet weak var videoCollectionView: UICollectionView! {
        didSet {
            videoCollectionView.delegate = self
            videoCollectionView.dataSource = self
            let videoNib = UINib(nibName: Cells.videoColectionCellNib.rawValue, bundle: nil)
            videoCollectionView.register(videoNib, forCellWithReuseIdentifier: Cells.videoCollectionCellIdentifier.rawValue)
        }
    }
    //MARK:- lifecycle-
    override func viewDidLoad() {
               super.viewDidLoad()
        
                requestDetail()
                requestCast()
                requestCrew()
                requestVideos()
                
           }
    //MARK:- Private func-
    private func requestCast() {
        networkManager.requestCast(detailId ?? 0) { (detailedCast) in
               DispatchQueue.main.async {
                   self.detailCast = detailedCast
                   self.castCollectionView.reloadData()
               }
           }
       }
    private func requestCrew() {
        networkManager.requestCrew(detailId ?? 0) { (detailedCrew) in
            DispatchQueue.main.async {
                self.detailCrew = detailedCrew
                self.crewCollectionView.reloadData()
            }
        }
    }
    private func requestDetail() {
         networkManager.requestDetailMovie(detailId ?? 0) { (detailedMovie) in
            self.results = detailedMovie
            self.updateView()
         }
    }
    private func requestVideos() {
              networkManager.requestVideos(detailId ?? 0) { (videos) in
                         DispatchQueue.main.async {
                             self.videos = videos
                             self.videoCollectionView.reloadData()
                }
        }
    }
    private func updateView() {
        DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.titleLabel.text = self.results?.title
                  if self.results?.voteAverage ?? 0 >= 5.0 {
                      self.voteAverageLabel.textColor = .green
                  } else {
                      self.voteAverageLabel.textColor = .orange
                  }
                self.voteAverageLabel.text = String(self.results!.voteAverage)
                self.dateLabel.text = self.results?.releaseDate
                self.releasedLabel.text = self.results?.releaseDate
                self.overviewLabel.text = self.results?.overview
                  guard
                      let runTime = self.results?.runtime,
                      let posterPath = self.results?.backdropPath,
                      let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                  else { return }
                self.runTimeLabel.text = "\(runTime) minutes"
                self.languageLabel.text = self.results?.originalLanguage
                self.detailImageView.kf.setImage(with: url)
                  if self.results?.budget == 0 {
                                      self.budgetLabel.text = "Information is coming soon"
                                  } else {
                                      self.budgetLabel.text = "\(self.results!.budget)$"
                                  }
                self.activityIndicator.stopAnimating()
               }
    }
}

    //MARK:- Configure collection view -
extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return detailCast.count
        } else if collectionView == crewCollectionView{
            return detailCrew.count
        } else {
            return videos.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == castCollectionView {
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.castCollectionCellIdentefier.rawValue, for: indexPath) as! CastCollectionViewCell
            castCell.configure(detailCast[indexPath.row])
            
            return castCell
            
        } else if collectionView == crewCollectionView {
            let crewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.crewCollectionCellIdentifier.rawValue, for: indexPath) as! CrewCollectionViewCell
           crewCell.configure(detailCrew[indexPath.row])
            return crewCell
        } else {
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.videoCollectionCellIdentifier.rawValue, for: indexPath) as! VideoCollectionViewCell
            videoCell.configure(videos[indexPath.row])
            return videoCell
        }
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == videoCollectionView {
            extractor.getUrlFromKey(key: videos[indexPath.row].key) { [weak self] (url) in
                guard let self = self else { return }
                let player = AVPlayer(url: url)
                let avPlayerViewController = AVPlayerViewController()
                avPlayerViewController.player = player
                self.present(avPlayerViewController, animated: true) {
                    avPlayerViewController.player?.play()
                }
            }
        } else if collectionView == castCollectionView {
            let desVC = storyboard?.instantiateViewController(identifier: "PeopleViewController") as! PeopleViewController
            desVC.detailedInfoCast = detailCast[indexPath.row]
            desVC.detailId = detailCast[indexPath.row].id
            desVC.detailPhoto = detailCast[indexPath.row].profilePath
            navigationController?.pushViewController(desVC, animated: true)
        } else if collectionView == crewCollectionView {
            let desVC = storyboard?.instantiateViewController(identifier: "PeopleViewController") as! PeopleViewController
            desVC.detailedInfoCrew = detailCrew[indexPath.row]
            desVC.detailId = detailCrew[indexPath.row].id
             desVC.detailPhoto = detailCrew[indexPath.row].profilePath
            navigationController?.pushViewController(desVC, animated: true)
        }
    }
}
