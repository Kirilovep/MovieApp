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
}

enum Segue: String {
    case segueToDetailView = "segueToDetailView"
}


enum Images: String {
    case imageForPeople = "defaultuser"
}
