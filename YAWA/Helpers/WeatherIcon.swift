//
//  WeatherIcon.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation

/// https://erikflowers.github.io/weather-icons/
/// according to this website
struct WeatherIcon {
    let iconText: String
    var code: String?
    
    enum IconType: String, CustomStringConvertible {
        case ClearSkyDay = "01n"
        case ClearSkyNight = "01d"
        case FewCloudsDay = "02n"
        case FewCloudsNight = "02d"
        case ScatteredCloudsDay = "03n"
        case ScatteredCloudsNight = "03d"
        case BrokenCloudsDay = "04n"
        case BrokenCloudsNight = "04d"
        case ShowerRainDay = "09n"
        case ShowerRainNight = "09d"
        case RainDay = "10n"
        case RainNight = "10d"
        case ThunderstormDay = "11n"
        case ThunderstormNight = "11d"
        case SnowDay = "13n"
        case SnowNight = "13d"
        case MistDay = "50n"
        case MistNight = "50d"
        
        
        var description: String {
            switch self {
                case .ClearSkyDay: return "\u{f00d}"
                case .ClearSkyNight: return "\u{f02e}"
                case .FewCloudsDay: return "\u{f002}"
                case .FewCloudsNight: return "\u{f086}"
                case .ScatteredCloudsDay: return "\u{f041}"
                case .ScatteredCloudsNight: return "\u{f041}"
                case .BrokenCloudsDay: return "\u{f013}"
                case .BrokenCloudsNight: return "\u{f013}"
                case .ShowerRainDay: return "\u{f01a}"
                case .ShowerRainNight: return "\u{f01a}"
                case .RainDay: return "\u{f008}"
                case .RainNight: return "\u{f036}"
                case .ThunderstormDay: return "\u{f010}"
                case .ThunderstormNight: return "\u{f03b}"
                case .SnowDay: return "\u{f00a}"
                case .SnowNight: return "\u{f038}"
                case .MistDay: return "\u{f003}"
                case .MistNight: return "\u{f04a}"
            }
        }
        
    }
    
    init(code: String) {
        guard let iconType = IconType(rawValue: code) else {
            iconText = ""
            return
        }
        self.code = code
        iconText = iconType.description
    }
}
