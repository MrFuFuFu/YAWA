//
//  ViewController.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell
        if let cell = cell as? WeatherTableViewCell {
            //todo
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell?.selectionStyle = .none
        }
        return cell!
    }
}
