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
    private var searchResultsPeople: [ResultsSearch] = []
    private var segment: UISegmentedControl = UISegmentedControl(items: ["Movies", "People"])
    //MARK:- IBOutlets-
    @IBOutlet weak var searchTableView: UITableView! {
        didSet {
            searchTableView.delegate = self
            searchTableView.dataSource = self
            searchTableView.tableFooterView = UIView()
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            searchTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            searchTableView.rowHeight = 150
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
        configureSegment()
    }
    
    
    //MARK:- private func-
    
    private func configureSegment() {
        segment.setTitle("Search Movie", forSegmentAt: 0)
        segment.sizeToFit()
        segment.selectedSegmentIndex = 0
        segment.frame.size.width = 500
        self.navigationItem.titleView = segment
        segment.addTarget(self, action: #selector(SearchViewController.indexChanged(_:)), for: .valueChanged)
        segment.backgroundColor = .clear
        segment.tintColor = .clear
        
        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        
        segment.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "forSegmentedColor")], for: .selected)
    }
    
    private func searchMovie(_ quary: String) {
        networkManager.searchMovie(quary) { (searchResults) in
            DispatchQueue.main.async {
                self.searchResultsMovies = searchResults
                self.searchTableView.reloadData()
            }
        }
    }
    
    private func searchPeople(_ quary: String) {
        networkManager.searchPeople(quary) { (searchPeopleResults) in
            DispatchQueue.main.async {
                self.searchResultsPeople = searchPeopleResults
                self.searchTableView.reloadData()
            }
        }
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            segment.setTitle("SearchMovies", forSegmentAt: 0)
            segment.setTitle("People", forSegmentAt: 1)
            searchResultsMovies = []
            searchResultsPeople = []
            searchTableView.reloadData()
        } else if segment.selectedSegmentIndex == 1 {
            segment.setTitle("SearchPeople", forSegmentAt: 1)
            segment.setTitle("Movies", forSegmentAt: 0)
            searchResultsMovies = []
            searchResultsPeople = []
            searchTableView.reloadData()
        }
    }
}
//MARK:- TableView extension -

extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segment.selectedSegmentIndex {
        case 0:
            return searchResultsMovies.count
        case 1:
            return searchResultsPeople.count
        default:
            break
        }
        return searchResultsMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        switch segment.selectedSegmentIndex {
        case 0:
            cell.configure(searchResultsMovies[indexPath.row])
        case 1:
            cell.configurePeople(searchResultsPeople[indexPath.row])
        default:
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
        desVC.detailId = searchResultsMovies[indexPath.row].id
        navigationController?.pushViewController(desVC, animated: true)
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK:- configure searchBar -
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch segment.selectedSegmentIndex {
        case 0:
            guard let searchQuary = searchBar.text else { return }
            quary = searchQuary
            searchMovie(quary)
            searchTableView.reloadData()
        case 1:
            guard let searchQuary = searchBar.text else { return }
            quary = searchQuary
            searchPeople(quary)
        default:
            break
        }
        if searchBar.text?.isEmpty == true {
            searchResultsPeople = []
            searchResultsMovies = []
            searchTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultsMovies = []
        searchResultsPeople = []
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
