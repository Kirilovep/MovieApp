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

        DispatchQueue.main.async {
            self.nameLabel.text = self.detailedInfo?.name
            self.setImage()

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
    
}
