//
//  PeopleViewController.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
class PeopleViewController: UIViewController {
    
    var personInfo: People?
    var detailedInfo: Cast?
    private let networkManager = NetworkManager()
    //MARK:- IBOutlets-
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthdayLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var knowsForLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var moviesTableView: UITableView!
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        parseInfo()
        
        DispatchQueue.main.async {
            self.nameLabel.text = self.detailedInfo?.name
            self.setImage()
            self.birthdayLabel.text = self.personInfo?.birthday
            self.placeOfBirthdayLabel.text = self.personInfo?.placeOfBirth
            self.knowsForLabel.text = self.personInfo?.knownForDepartment
            self.biographyLabel.text = self.personInfo?.biography
            self.biographyLabel.numberOfLines = 2
            self.biographyLabel.lineBreakMode = .byWordWrapping
            self.biographyLabel.sizeToFit()
            

        }
        
    }
    
    
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
        }
    }
    
}
