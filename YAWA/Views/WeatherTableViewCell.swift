//
//  WeatherTableViewCell.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var weatherOvernight: WeatherView!
    @IBOutlet weak var weatherMorning: WeatherView!
    @IBOutlet weak var weatherAfternoon: WeatherView!
    @IBOutlet weak var weatherEvening: WeatherView!
    
    var weathers: [Weather]? {
        didSet {
            if let weathers = weathers, weathers.count > 0 {
                if let date = weathers[0].date {
                    labelDay.text = Date.dateToDateString(date)
                }
                
                weathers.forEach {
                    if let date = $0.date {
                        let timeStr = Date.dateToTimeString(date)
                        switch timeStr {
                        case DayTime.Overnight.rawValue:
                            weatherOvernight.weather = $0
                        case DayTime.Morning.rawValue:
                            weatherMorning.weather = $0
                        case DayTime.Afternoon.rawValue:
                            weatherAfternoon.weather = $0
                        case DayTime.Evening.rawValue:
                            weatherEvening.weather = $0
                        default:
                            break
                        }
                    }
                    
                }
            }
        }
    }
    
    var row: Int? {
        didSet {
            if let row = row, row < 6 {
                shadowView.backgroundColor = UIColor.randomColor[row]
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.clipsToBounds = true
        shadowView.layer.cornerRadius = 8
        shadowView.addShadow()
    }
}
