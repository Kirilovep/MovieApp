//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by shizo on 04.11.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var detailMovies: [MovieCoreData] = []
    
    //MARK:- IBOutlets
    @IBOutlet weak var favoritesTableView: UITableView! {
        didSet {
            favoritesTableView.delegate = self
            favoritesTableView.dataSource = self
            
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            favoritesTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            favoritesTableView.rowHeight = 150
            favoritesTableView.tableFooterView = UIView()
        }
    }
    
    
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }


    //MARK: - Private func -
    private func getData() {
        do {
            detailMovies = try context.fetch(MovieCoreData.fetchRequest())
            favoritesTableView.reloadData()
        } catch {
            print("Fetching Failed")
        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        cell.configureFromCoreData(detailMovies[indexPath.row])
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          let task = detailMovies[indexPath.row]
          context.delete(task)
          (UIApplication.shared.delegate as! AppDelegate).saveContext()

          do {
            detailMovies = try context.fetch(MovieCoreData.fetchRequest())
          } catch {
            print("Fetching Failed")
          }
        }
         favoritesTableView.reloadData()
       }
    
}
