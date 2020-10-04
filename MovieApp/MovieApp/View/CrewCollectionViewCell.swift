//
//  CrewCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 03.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {

    let Secondimage = #imageLiteral(resourceName: "defaultuser")
    
    @IBOutlet weak var indicatorImage: UIActivityIndicatorView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(_ crew: Crew) {
        DispatchQueue.main.async {
            self.indicatorImage.startAnimating()
            self.nameLabel.text = crew.name
            self.jobLabel.text = crew.job
          if let profilePath = crew.profilePath {
                           let url = URL(string: Urls.baseImageUrl.rawValue + profilePath )
                           self.characterImage.kf.setImage(with: url)
                       } else {
                           self.characterImage.image = UIImage(named: Images.imageForPeople.rawValue)
                       }
            self.indicatorImage.stopAnimating()
        }
    }

    
 
}




