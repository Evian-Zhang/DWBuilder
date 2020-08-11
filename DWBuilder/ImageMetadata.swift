//
//  ImageMetadata.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import Foundation

struct ImageMetadata {
    let url: URL
    let latitude: Double
    let date: Date
    
    init(url: URL, latitude: Double, date: Date) {
        self.url = url
        self.latitude = latitude
        self.date = date
    }
    
    var solarAngle: SolarAngle {
        SolarAngle(latitude: self.latitude, date: self.date)
    }
}

struct SolarAngle {
    let altitude: Double
    let azimuth: Double
    
    init(latitude: Double, date: Date) {
        // Preprocessing
        let latitude = toArc(latitude)
        
        let calendar = Calendar.current
        let imageDateComponent = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let hourAngle = toArc((Double(imageDateComponent.hour!) + Double(imageDateComponent.minute!) / 60.0 + Double(imageDateComponent.second!) / 3600.0 - 12.0) * 15.0)
        
        let totalDay = calendar.ordinality(of: .day, in: .year, for: date)!
        let dayAngle = 2 * Double.pi * (Double(totalDay) - 1) / 365.0
        let declination = 0.006918 - 0.399912 * cos(dayAngle) + 0.070257 * sin(dayAngle) - 0.006758 * cos(2 * dayAngle) + 0.000907 * sin(2 * dayAngle) - 0.002697 * cos(3 * dayAngle) + 0.00148 * sin(3 * dayAngle)
        
        // compute altitude
        var sinOfAltitude = sin(latitude) * sin(declination) + cos(latitude) * cos(declination) * cos(hourAngle)
        if sinOfAltitude > 1.0 {
            sinOfAltitude = 1.0
        }
        if sinOfAltitude < 0.0 {
            sinOfAltitude = -1.0
        }
        
        self.altitude = asin(sinOfAltitude) * 180.0 / Double.pi
        
        // compute azimuth
        var cosOfAzimuth = (sin(declination) * cos(latitude) - cos(declination) * sin(latitude) * cos(hourAngle)) / sqrt(1 - sinOfAltitude * sinOfAltitude)
        if cosOfAzimuth > 1.0 {
            cosOfAzimuth = 1.0
        }
        if cosOfAzimuth < 0.0 {
            cosOfAzimuth = -1.0
        }
        
        var azimuth = acos(cosOfAzimuth) * 180.0 / Double.pi
        if hourAngle > 0.0 {
            azimuth = 360 - azimuth
        }
        self.azimuth = azimuth
    }
}

private func toArc(_ degree: Double) -> Double {
    degree * Double.pi / 180.0
}
