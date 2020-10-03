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
    case crewCollectionIdentefier = "CrewCollectionCell"
    case crewCollectionCellNib = "CrewCollectionViewCell"
}

enum Segue: String {
    case segueToDetailView = "segueToDetailView"
}

