//
//  ViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //MARK:- Properties -
    private var currentPageUpcoming = 1
    private var currentPageTopRated = 1
    private var currentPageNowPlaying = 1
    private var nowPlayingMovieList: [Result] = []
    private var topRatedMovies: [Result] = []
    private var upcomingMovies: [Result] = []
    private var networkManager = NetworkManager()
    //MARK:- IBOutlets-
    @IBOutlet weak var mainSegmentedControl: UISegmentedControl! {
        didSet {
            mainSegmentedControl.backgroundColor = .clear
            mainSegmentedControl.tintColor = .clear
            
            mainSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
            
            mainSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        }
    }
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.delegate = self
            mainTableView.dataSource = self
            mainTableView.prefetchDataSource = self
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            mainTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            mainTableView.rowHeight = 150
        }
    }
    //MARK:- LifeCycles-
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNowPlayingMovies(Urls.nowPlayingMovie.rawValue)
        requestTopRatedMovies(Urls.topRatedMovie.rawValue)
        requestUpcomingMovies(Urls.upcomingMovie.rawValue)
        self.tabBarController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- IBActions-
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mainTableView.reloadData()
        case 1:
            mainTableView.reloadData()
        case 2:
            mainTableView.reloadData()
        default:
            break
        }
    }
    //MARK:- Private Func -
    private func requestNowPlayingMovies(_ filterForSearch: String) {
        networkManager.loadMovies(filterForSearch, currentPageNowPlaying)  { [weak self] (results) in
            DispatchQueue.main.async {
                self?.nowPlayingMovieList += results
                self?.mainTableView.reloadData()
            }
        }
    }
    
    private func requestTopRatedMovies(_ filterForSearch: String) {
        networkManager.loadMovies(filterForSearch, currentPageTopRated)  { [weak self] (results) in
            DispatchQueue.main.async {
                self?.topRatedMovies += results
                self?.mainTableView.reloadData()
            }
        }
    }
    private func requestUpcomingMovies(_ filterForSearch: String) {
        networkManager.loadMovies(filterForSearch, currentPageUpcoming)  { [weak self] (results) in
            DispatchQueue.main.async {
                self?.upcomingMovies += results
                self?.mainTableView.reloadData()
            }
        }
    }
    private func prefetchRows(for indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            switch mainSegmentedControl.selectedSegmentIndex {
            case 0:
                self.currentPageNowPlaying += 1
                requestNowPlayingMovies(Urls.nowPlayingMovie.rawValue)
            case 1:
                self.currentPageTopRated += 1
                requestTopRatedMovies(Urls.topRatedMovie.rawValue)
            case 2:
                self.currentPageUpcoming += 1
                requestUpcomingMovies(Urls.upcomingMovie.rawValue)
            default:
                break
            }
        }
    }
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        switch mainSegmentedControl.selectedSegmentIndex {
        case 0:
            return (indexPath.row) >= nowPlayingMovieList.count - 8
        case 1:
            return (indexPath.row) >= topRatedMovies.count - 5
        case 2:
            return (indexPath.row) >= upcomingMovies.count - 5
        default:
            break
        }
        return (indexPath.row) >= nowPlayingMovieList.count - 5
    }
}
    //MARK:- UITableView extension -
extension MainViewController: UITableViewDelegate,UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        prefetchRows(for: indexPaths)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mainSegmentedControl.selectedSegmentIndex {
        case 0:
            return nowPlayingMovieList.count
        case 1:
            return topRatedMovies.count
        case 2:
            return upcomingMovies.count
        default:
            break
        }
        return nowPlayingMovieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        switch mainSegmentedControl.selectedSegmentIndex {
        case 0:
            cell.configure(nowPlayingMovieList[indexPath.row])
        case 1:
            cell.configure(topRatedMovies[indexPath.row])
        case 2:
            cell.configure(upcomingMovies[indexPath.row])
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
        switch mainSegmentedControl.selectedSegmentIndex {
        case 0:
            desVC.detailId = nowPlayingMovieList[indexPath.row].id
        case 1:
            desVC.detailId = topRatedMovies[indexPath.row].id
        case 2:
            desVC.detailId = upcomingMovies[indexPath.row].id
        default:
            break
        }
        navigationController?.pushViewController(desVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
    //MARK:- TabBar extension -
extension MainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        if tabBarIndex == 0 {
            self.mainTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableView.ScrollPosition(rawValue: 0)!, animated: true)
            }
    }
}

