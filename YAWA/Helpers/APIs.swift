//
//  APIs.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class APIs {
    static let shared = APIs()
//    private let url: String = "http://api.openweathermap.org/data/2.5/forecast?q=Auckland&mode=json&units=metric&APPID=399a5bbd96e27a24b8f8c656e8c30ff4"
    private let url: String = "http://api.openweathermap.org/data/2.5/forecast?mode=json&units=metric&APPID=399a5bbd96e27a24b8f8c656e8c30ff4"
    
    func requestForecastBy(city: String, completion: @escaping ([[Weather]]?, Error?) -> Void) {
        let url = self.url + "&q=\(city)"
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let result = response.result.value as? [String: AnyObject] {
                    completion(Weather.operatWeather(json: JSON(result)), nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}