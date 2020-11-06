//
//  ViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
  
   private var movieList: [Result] = []
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
            
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            mainTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
            mainTableView.rowHeight = 150
        }
    }
    //MARK:- LifeCycles-
    override func viewDidLoad() {
        super.viewDidLoad()
        requestMovies(Urls.nowPlayingMovie.rawValue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- IBActions-
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            requestMovies(Urls.nowPlayingMovie.rawValue)
        case 1:
            requestMovies(Urls.topRatedMovie.rawValue)
        case 2:
            requestMovies(Urls.upcomingMovie.rawValue)
        default:
            break
        }
    }
    //MARK:- Private Func-

private func requestMovies(_ filterForSearch: String) {
    networkManager.loadMovies(filterForSearch)  { [weak self] (results) in
        DispatchQueue.main.async {
            self?.movieList = results
            self?.mainTableView.reloadData()
        }
    }
    }
}
    //MARK:- UITableView extension -
extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCellIdentefier.rawValue, for: indexPath) as! MainTableViewCell
        cell.configure(movieList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desVC = storyboard?.instantiateViewController(identifier: ViewControllers.DetailMovieVCIdentifier.rawValue) as! DetailMovieViewController
        desVC.detailId = movieList[indexPath.row].id
        navigationController?.pushViewController(desVC, animated: true)
        
         tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
