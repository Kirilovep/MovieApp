//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by shizo on 04.11.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var favoritesTableView: UITableView! {
        didSet {
            favoritesTableView.delegate = self
            favoritesTableView.dataSource = self
            
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            favoritesTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            favoritesTableView.rowHeight = 150
        }
    }
    
    
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}


extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        //cell.configure(movieList[indexPath.row])
        return cell
    }
    
    
}
