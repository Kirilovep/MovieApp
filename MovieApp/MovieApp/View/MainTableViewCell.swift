//
//  MainTableViewCell.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    func configure(_ result: Result) {
        DispatchQueue.main.async {
            self.titleLabel.text = result.title
            if result.voteAverage >= 5.0 {
                self.voteAverageLabel.textColor = .green
            } else {
                self.voteAverageLabel.textColor = .orange
            }
            self.voteAverageLabel.text = String(result.voteAverage)
            self.overviewLabel.text = result.overview
            self.releaseDataLabel.text = result.releaseDate
            let url = URL(string: Urls.baseImageUrl.rawValue + result.posterPath)
            self.posterImage.kf.setImage(with: url)
        }
        
    }
    
}
