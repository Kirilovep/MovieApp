//
//  DetailCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 02.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    let firstImage = #imageLiteral(resourceName: "defaultuser")
   
    @IBOutlet weak var indicatorImage: UIActivityIndicatorView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var jobLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //characterImage.clipsToBounds = true
    }

    
    func configure(_ cast: Cast) {
        DispatchQueue.main.async {
            self.indicatorImage.startAnimating()
            self.fullName.text = cast.name
            self.jobLabel.text = cast.character
            if let profilePath = cast.profilePath {
                let url = URL(string: Urls.baseImageUrl.rawValue + profilePath )
                self.characterImage.kf.setImage(with: url)
            } else {
                self.characterImage.image = UIImage(named: Images.imageForPeople.rawValue)
            }
            
            
                 self.indicatorImage.stopAnimating()
            
            
          
           
            
        }
    }
}
