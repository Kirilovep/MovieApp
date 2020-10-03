//
//  CrewCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 03.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {

    let image = #imageLiteral(resourceName: "noImage")
    
    @IBOutlet weak var indicatorImage: UIActivityIndicatorView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(_ crew: Crew) {
        DispatchQueue.main.async {
            self.indicatorImage.startAnimating()
            self.nameLabel.text = crew.job
            guard let profilePath = crew.profilePath else { return }
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePath)
            if crew.profilePath == nil {
                self.characterImage.image = self.image
            } else {
                self.characterImage.kf.setImage(with: url)
            }
            
            self.indicatorImage.stopAnimating()
        }
    }

}
