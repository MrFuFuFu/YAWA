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
    
    var arrayWeathers: [[Weather]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        request(city: "Auckland")
    }
    
    private func request(city: String) {
        APIs.shared.requestForecastBy(city: city) { [weak self] (arrayWeathers, error) in
            guard let `self` = self else { return }
            if let arrayWeathers = arrayWeathers {
                `self`.arrayWeathers = arrayWeathers
                `self`.tableView.reloadData()
            } else if let error = error {
                print(error.localizedDescription)
            } else {
                print("No result")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeathers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell
        if let cell = cell as? WeatherTableViewCell {
            cell.weathers = arrayWeathers[indexPath.row]
            cell.row = indexPath.row
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.selectionStyle = .none
        return cell!
    }
}
