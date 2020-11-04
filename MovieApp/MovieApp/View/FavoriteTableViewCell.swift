//
//  FavoriteTableViewCell.swift
//  MovieApp
//
//  Created by shizo on 04.11.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    
    func configureFromCoreData(_ result: MovieCoreData) {
          DispatchQueue.main.async {
              self.titleLabel.text = result.title
              if result.voteAverage >= 5.0 {
                  self.voteAverageLabel.textColor = .green
              } else {
                  self.voteAverageLabel.textColor = .orange
              }
              self.voteAverageLabel.text = String(result.voteAverage)
              self.releaseDataLabel.text = result.releaseDate
              self.overviewLabel.text = result.overview
              if let posterPath = result.image {
                  let url = URL(string: Urls.baseImageUrl.rawValue + posterPath)
                  self.posterImage.kf.setImage(with: url)
              }else {
                  self.posterImage.image = UIImage(named: Images.noPoster.rawValue)
              }
          }
      }
    
}
