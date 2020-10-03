//
//  DetailCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 02.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var indicatorImage: UIActivityIndicatorView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //characterImage.clipsToBounds = true
    }

    
    func configure(_ cast: Cast) {
        DispatchQueue.main.async {
            self.indicatorImage.startAnimating()
            self.fullName.text = cast.name
            guard let profilePath = cast.profilePath else { return }
            let url = URL(string: Urls.baseImageUrl.rawValue + profilePath)
            self.characterImage.kf.setImage(with: url)
            self.indicatorImage.stopAnimating()
            
        }
    }
}
