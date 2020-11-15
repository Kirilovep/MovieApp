//
//  CrewCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 03.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    //MARK:- IBOutlets -
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    //MARK: - Functions -
    func configure(_ crew: Crew) {
            self.nameLabel.text = crew.name
            self.jobLabel.text = crew.job
            if let profilePath = crew.profilePath {
                let url = URL(string: Urls.baseImageUrl.rawValue + profilePath )
                self.characterImage.kf.indicatorType = .activity
                self.characterImage.kf.setImage(with: url)
            } else {
                self.characterImage.image = UIImage(named: Images.imageForPeople.rawValue)
            }
    }
}




