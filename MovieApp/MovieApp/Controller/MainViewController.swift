//
//  ViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //let networkManager = NetworkManager()
    var movieList: [Result] = []
    
    @IBOutlet weak var mainSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.delegate = self
            mainTableView.dataSource = self
            
            let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
            mainTableView.register(nib, forCellReuseIdentifier: Cells.mainCell.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.manager.getRequest(Urls.nowPlaying.rawValue) { (results) in
            DispatchQueue.main.async {
                self.movieList = results
                self.mainTableView.reloadData()
            }
        }
    }

    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
    }
    
}




extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCell.rawValue, for: indexPath) as! MainTableViewCell
        cell.configure(movieList[indexPath.row])
        return cell
    }
    
    
}
