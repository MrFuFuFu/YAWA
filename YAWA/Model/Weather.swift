//
//  Weather.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Weather {
    var temp: String
    var icon: String
    var desc: String
    var date: Date?
    
    init(temp: String, icon: String, desc: String, date: Date?) {
        self.temp = temp
        self.icon = icon
        self.desc = desc
        self.date = date
    }
}

extension Weather {
    
    static func operatWeather(json: JSON) -> [[Weather]] {
        let weathers = weathersFormate(json: json)
        let arrayWeathers = combineSameDay(weathers: weathers)
        return filterOtherTime(arrayWeathers)
    }
    
    /**
     * Formate json date to entity
     **/
    static func weathersFormate(json: JSON) -> [Weather] {
        var weathers: [Weather] = []
        let list = json["list"].arrayValue
        for item in list {
            let temp = item["main"]["temp"].stringValue
            var icon: String = "", desc: String = ""
            let weatherJsonArray = item["weather"].arrayValue
            if weatherJsonArray.count > 0 {
                icon = weatherJsonArray[0]["icon"].stringValue
                desc = weatherJsonArray[0]["main"].stringValue
            }
            let dt_txt = item["dt_txt"].stringValue
            
            let weather = Weather(temp: temp, icon: icon, desc: desc, date: Date.stringToDate(dt_txt))
            weathers.append(weather)
        }
        return weathers
    }
    
    /**
     * Combine same day to the same array
     **/
    static func combineSameDay(weathers: [Weather]) -> [[Weather]] {
        let datesOld = weathers.compactMap { $0.date }
        var datesUnique: [Date] = []
        
        datesOld.forEach {
            let dateOld = $0
            if !datesUnique.contains(where: { Date.isSameDay(date1: dateOld, date2: $0) }) {
                datesUnique.append(dateOld)
            }
        }
        
        var arrayWeathers: [[Weather]] = []
        
        datesUnique.forEach {
            let date = $0
            let filterArray = weathers.filter {Date.isSameDay(date1: $0.date, date2: date)}
            arrayWeathers.append(filterArray)
        }
        
        return arrayWeathers
    }
    
    /**
     * Only keep 3:00, 9:00, 15:00, 21:00
     **/
    static func filterOtherTime(_ arrayWeathers: [[Weather]]) -> [[Weather]] {
        var newArrayWeathers: [[Weather]] = []
        arrayWeathers.forEach { weathers in
            let filterWeathers = weathers.filter {
                   Date.timeCheck(.Overnight, date: $0.date)
                || Date.timeCheck(.Morning, date: $0.date)
                || Date.timeCheck(.Afternoon, date: $0.date)
                || Date.timeCheck(.Evening, date: $0.date)
            }
            newArrayWeathers.append(filterWeathers)
        }
        
        return newArrayWeathers
    }
}
