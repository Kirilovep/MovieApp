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
    private let networkManager = NetworkManager()
    
    //MARK:- IBOutlets-
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
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        parseInfo()
        parseImages()
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
            self.configureView()
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
    
    private func configureView() {
        DispatchQueue.main.async {
                  self.activityIndicator.startAnimating()
                  self.nameLabel.text = self.detailedInfo?.name
                  self.birthdayLabel.text = self.personInfo?.birthday
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
