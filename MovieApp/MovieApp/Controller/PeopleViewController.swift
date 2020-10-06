//
//  PeopleViewController.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
import ExpandableLabel

class PeopleViewController: UIViewController {
    
    var personInfo: People?
    var detailedInfo: Cast?
    var personImages: [Profile] = []
    var moviesForPeople: [CastForPeople] = []
    private let networkManager = NetworkManager()
    
    //MARK:- IBOutlets-
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthdayLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView! {
        didSet {
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
            
            let nib = UINib(nibName: Cells.imageCollectionNib.rawValue, bundle: nil)
            imagesCollectionView.register(nib, forCellWithReuseIdentifier: Cells.imageCollectionCellIdentifier.rawValue)
        }
    }
    @IBOutlet weak var knowsForLabel: UILabel!
    @IBOutlet weak var biographyLabel: ExpandableLabel!
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView.delegate = self
            moviesTableView.dataSource = self
            
            let nib = UINib(nibName: Cells.moviesTableViewCellNib.rawValue, bundle: nil)
            moviesTableView.register(nib, forCellReuseIdentifier: Cells.moviesCellIdentifier.rawValue)
            
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        parseInfo()
        parseImages()
        parseMovies()
       
    }
    
    //MARK:- Private methods-
    private func setImage() {
        if let profilePath = self.detailedInfo?.profilePath {
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePath )
            self.characterImage.kf.setImage(with: url)
        } else {
            self.characterImage.image = UIImage(named: Images.imageForPeople.rawValue)
        }
    }
    private func parseInfo() {
        networkManager.requestPeople(detailedInfo?.id ?? 0) { (infoPeople) in
            self.personInfo = infoPeople
            self.updateView()
        }
    }
    private func parseImages() {
        networkManager.requestPersonImages(detailedInfo?.id ?? 0) { (images) in
            self.personImages = images
            DispatchQueue.main.async {
                self.imagesCollectionView.reloadData()
            }
        }
    }
    private func parseMovies() {
        networkManager.requestMoviesForPeople(detailedInfo?.id ?? 0) { (moviesForPeople) in
                   DispatchQueue.main.async {
                        self.moviesForPeople = moviesForPeople
                        self.tableViewHeight.constant = CGFloat(moviesForPeople.count * 70)
                        self.moviesTableView.reloadData()
                   }
               }
    }
    private func updateView() {
        DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.nameLabel.text = self.detailedInfo?.name
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let birthday = self.personInfo?.birthday, let date = dateFormatter.date(from: birthday) {
                    dateFormatter.dateFormat = "MMMM dd, yyyy"
                    self.birthdayLabel.text = dateFormatter.string(from: date)
                  }
                self.placeOfBirthdayLabel.text = self.personInfo?.placeOfBirth
                self.knowsForLabel.text = self.personInfo?.knownForDepartment
                self.biographyLabel.shouldCollapse = true
                self.biographyLabel.numberOfLines = 4
                self.biographyLabel.collapsedAttributedLink = NSAttributedString(
                      string: "Show more", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
                  )
                self.biographyLabel.expandedAttributedLink = NSAttributedString(
                      string: "Show less", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
                  )
                self.biographyLabel.text = self.personInfo?.biography
                self.setImage()
                self.activityIndicator.stopAnimating()
              }
    }
}
//MARK:- Configure collectionView -
extension PeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.imageCollectionCellIdentifier.rawValue, for: indexPath) as! ImageCollectionViewCell
        cell.configure(personImages[indexPath.row])
        return cell
    }
}
//MARK:- Configure tableView -
extension PeopleViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesForPeople.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.moviesCellIdentifier.rawValue, for: indexPath) as! MoviesTableViewCell
        cell.configure(moviesForPeople[indexPath.row])
        return cell
    }
}
