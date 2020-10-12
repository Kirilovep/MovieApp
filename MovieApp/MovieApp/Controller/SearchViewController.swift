//
//  SearchViewController.swift
//  MovieApp
//
//  Created by shizo on 11.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var networkManager = NetworkManager()
    private var quary = ""
    private var searchResultsMovies: [Result] = []
    //MARK:- IBOutlets-
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
            searchTableView.tableFooterView = UIView()
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            searchTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
        }
    }
    @IBOutlet weak var movieSearchBar: UISearchBar! {
        didSet {
            movieSearchBar.delegate = self
            movieSearchBar.showsCancelButton = true
        }
    }
    //MARK:- lifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

  //MARK:- private func-
    private func searchMovie(_ quary: String) {
        networkManager.searchRequest(quary) { (searchResults) in
            DispatchQueue.main.async {
                self.searchResultsMovies = searchResults
                self.searchTableView.reloadData()
            }
        }
    }
}
//MARK:- configure tableView-

extension SearchViewController: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return searchResultsMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        cell.configure(searchResultsMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
        desVC.detailId = searchResultsMovies[indexPath.row].id
        navigationController?.pushViewController(desVC, animated: true)
        
        //performSegue(withIdentifier: Segue.segueToDetailView.rawValue, sender: indexPath)
         tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK:- configure searchBar -
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchQuary = searchBar.text else { return }
        quary = searchQuary
        searchMovie(quary)
        
        if searchBar.text?.isEmpty == true {
            searchResultsMovies = []
            searchTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultsMovies = []
        searchTableView.reloadData()
        if searchBar.text?.isEmpty == true {
            view.endEditing(true)
        } else {
            searchBar.text? = ""
            view.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
