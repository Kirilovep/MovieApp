//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by shizo on 06.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    func configure(_ movies: CastForPeople) {
        DispatchQueue.main.async {
            self.titleLabel.text = movies.title
            if movies.voteAverage >= 5.0 {
                self.voteAverageLabel.textColor = .green
            } else {
                self.voteAverageLabel.textColor = .orange
            }
            self.voteAverageLabel.text = "\(movies.voteAverage)"
            self.characterLabel.text = "as \(movies.character)"
            if let posterPath = movies.posterPath {
                let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                self.movieImage.kf.setImage(with: url)
            } else {
                self.movieImage.image = UIImage(named: Images.noPoster.rawValue)
            }
            
        }
        
    }
    
}
