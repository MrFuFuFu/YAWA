//
//  WeatherTableViewCell.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var labelWeek: UILabel!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var weather3: WeatherView!
    @IBOutlet weak var weather9: WeatherView!
    @IBOutlet weak var weather15: WeatherView!
    @IBOutlet weak var weather21: WeatherView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
