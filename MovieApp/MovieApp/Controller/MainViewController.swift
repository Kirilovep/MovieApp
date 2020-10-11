//
//  ViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    var movieList: [Result] = []
    
    //MARK:- IBOutlets-
    @IBOutlet weak var mainSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.delegate = self
            mainTableView.dataSource = self
            
            let nib = UINib(nibName: Cells.mainCellNib.rawValue, bundle: nil)
            mainTableView.register(nib, forCellReuseIdentifier: Cells.mainCellIdentefier.rawValue)
        }
    }
    //MARK:- LifeCycles-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestMovie(Urls.nowPlayingMovie.rawValue)
        
    }
    
    //MARK:- IBActions-
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            requestMovie(Urls.nowPlayingMovie.rawValue)
        case 1:
            requestMovie(Urls.topRatedMovie.rawValue)
        case 2:
            requestMovie(Urls.upcomingMovie.rawValue)
        default:
            break
        }
    }
    //MARK:- Private Func-

private func requestMovie(_ filterForSearch: String) {
    NetworkManager.manager.getRequest(filterForSearch)  { [weak self] (results) in
        DispatchQueue.main.async {
            self?.movieList = results
            self?.mainTableView.reloadData()
        }
    }
    }
}
    //MARK:- Extenstions-
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
        let desVC = storyboard?.instantiateViewController(identifier: "DetailMovieViewController") as! DetailMovieViewController
        desVC.detailResult = movieList[indexPath.row]
        desVC.detailId = movieList[indexPath.row].id
        navigationController?.pushViewController(desVC, animated: true)
        
        //performSegue(withIdentifier: Segue.segueToDetailView.rawValue, sender: indexPath)
         tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
