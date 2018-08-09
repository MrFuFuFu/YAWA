//
//  ViewController.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
//    let locationManager = CLLocationManager()
    
    var arrayWeathers: [[Weather]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        
        initLocationService()
        locationRequest()
    }
    
    private func locationRequest() {
        LocationServices.shared.getAdress { [weak self] locality in
            guard let `self` = self else { return }
            `self`.title = locality
            `self`.weatherRequest(locality: locality)
        }
    }
    
    private func weatherRequest(locality: String) {
        print("weatherRequest", locality)
        APIs.shared.requestForecastBy(locality: locality) { [weak self] (arrayWeathers, error) in
            guard let `self` = self else { return }
            if let arrayWeathers = arrayWeathers {
                `self`.title = locality
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

extension ViewController: CLLocationManagerDelegate {
    func initLocationService(){
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationRequest()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        weatherRequest(locality: text)
    }
}
