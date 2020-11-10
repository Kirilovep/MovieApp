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
    //MARK:- Properties -
    static let size = CGSize(width: 51, height: 77)
    
    //MARK: - IBOutlets -
    @IBOutlet weak var personImage: UIImageView!
    
    //MARK: - LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        
        personImage.layer.cornerRadius = 4
        personImage.clipsToBounds = true
    }
    
    //MARK: - Functions -
    func configure(_ people: Profile) {
        let url = URL(string: Urls.baseImageUrl.rawValue + people.filePath)
        personImage.kf.indicatorType = .activity
        personImage.kf.setImage(with: url)
    }
}


