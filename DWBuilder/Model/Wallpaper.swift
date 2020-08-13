//
//  Wallpaper.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import Foundation

struct Wallpaper: Encodable {
    let sequenceItems: [WallpaperImage]
    let appearance: Appearance
    
    enum CodingKeys: String, CodingKey {
        case sequenceItems = "si"
        case appearance = "ap"
    }
}

struct WallpaperImage: Encodable {
    let altitude: Double
    let azimuth: Double
    let imageIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case altitude = "a"
        case azimuth = "z"
        case imageIndex = "i"
    }
}

struct Appearance: Encodable {
    let lightIndex: Int
    let darkIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case lightIndex = "l"
        case darkIndex = "d"
    }
}
