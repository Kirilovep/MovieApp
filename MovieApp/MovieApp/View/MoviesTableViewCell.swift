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
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    func configure(_ movies: PersonMovie) {
        DispatchQueue.main.async {
            if let moviesName = movies.title {
                 self.titleLabel.text = moviesName
            }
            if let moviesAverage = movies.voteAverage {
                self.voteAverageLabel.text = "\(moviesAverage)"
            }
            if let averageVote = movies.voteAverage {
                if averageVote >= 5.0 {
                    self.voteAverageLabel.textColor = .green
                } else if averageVote <= 4.9 {
                    self.voteAverageLabel.textColor = .orange
                } else if averageVote <= 3.0 {
                    self.voteAverageLabel.textColor = .red
            }
            if let characterName = movies.character {
                self.characterLabel.text = "as \(characterName)"
            }
            if let posterPath = movies.posterPath {
                let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                self.movieImage.kf.setImage(with: url)
            } else {
                self.movieImage.image = UIImage(named: Images.noPoster.rawValue)
            }
            if let releaseData = movies.releaseDate {
                self.yearLabel.text = releaseData
            }
            
        }
        
    }
    
}




}
