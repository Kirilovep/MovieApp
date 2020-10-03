//
//  CrewCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 03.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func configure(_ crew: Crew) {
           DispatchQueue.main.async {
               self.fullName.text = cast.name
               guard let profilePath = cast.profilePath else { return }
               let url = URL(string: Urls.baseImageUrl.rawValue + profilePath)
               self.characterImage.kf.setImage(with: url)
               
           }
       }
}
