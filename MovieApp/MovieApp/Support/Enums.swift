//
//  Enums.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import Foundation


enum Cells:String {
    case mainCellIdentefier = "mainCell"
    case mainCellNib = "MainTableViewCell"
    case castCollectionCellIdentefier = "collectionCell"
    case castCollectionCellNib = "CastCollectionViewCell"
    case crewCollectionCellIdentifier = "crewCell"
    case crewCollectionCellNib = "CrewCollectionViewCell"
    case videoCollectionCellIdentifier = "videoCell"
    case videoColectionCellNib = "VideoCollectionViewCell"
    case imageCollectionCellIdentifier = "imageCollectionCell"
    case imageCollectionNib = "ImageCollectionViewCell"
    case moviesCellIdentifier = "movieCell"
    case moviesTableViewCellNib = "MoviesTableViewCell"
}

enum Segue: String {
    case segueToDetailView = "segueToDetailView"
    case segueToPerson = "segueToPerson"
}


enum Images: String {
    case imageForPeople = "defaultuser"
    case noPoster = "noImage"
}


enum ViewControllers: String {
    case DetailMovieVCIdentifier = "DetailMovieViewController"
    case PeopleVCIdentifier = "PeopleViewController"
}
