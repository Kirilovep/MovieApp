//
//  ViewController.swift
//  MovieApp
//
//  Created by shizo on 01.10.2020.
//  Copyright © 2020 Kyrylov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

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
        // Do any additional setup after loading the view.
    }


}




extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mainCell.rawValue, for: indexPath)
        return cell
    }
    
    
}
