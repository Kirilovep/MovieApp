//
//  ImageCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 06.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
class ImageCollectionViewCell: UICollectionViewCell {

     static let size = CGSize(width: 51, height: 77)
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        personImage.layer.cornerRadius = 4
        personImage.clipsToBounds = true
    }

    func configure(_ people: Profile) {
        let url = URL(string: Urls.baseImageUrl.rawValue + people.filePath)
        personImage.kf.indicatorType = .activity
        personImage.kf.setImage(with: url)
    }
}


