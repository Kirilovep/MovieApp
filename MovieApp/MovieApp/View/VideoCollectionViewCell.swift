//
//  VideoCollectionViewCell.swift
//  MovieApp
//
//  Created by shizo on 05.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit
import Kingfisher
class VideoCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var trailerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        videoImage.layer.cornerRadius = 5
               videoImage.clipsToBounds = true
    }
    
    
    enum videourls:String {
        case baseurl = "https://img.youtube.com/vi/"
        case lasturl = "/0.jpg"
    }
    
    func configure(_ video: Video) {
        DispatchQueue.main.async {
            self.trailerName.text = video.name
            if let key = video.key {
                let url = URL(string: videourls.baseurl.rawValue + key + videourls.lasturl.rawValue )
                self.videoImage.kf.setImage(with: url)
            } else {
                self.videoImage.image = UIImage(named: Images.imageForPeople.rawValue)
            }
            //let urlVideo = URL(string: "https://img.youtube.com/vi/\(key)/0.jpg") {
            //self.videoImage.kf.setImage(url: urlVideo)

        }
        
    }

}
//XPG0MqIcby8
//
//https://img.youtube.com/vi/XPG0MqIcby8/0.jpg
