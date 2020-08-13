//
//  WallpaperGenerator.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import Foundation
import AppKit
import AVFoundation

struct GeneratorConfig {
    let lightIndex: Int
    let darkIndex: Int
}

func generateWallpaper(config: GeneratorConfig, imageMetadatas: [ImageMetadata]) throws -> Data {
    let options = [kCGImageDestinationLossyCompressionQuality: 1.0]
    let wallpaperMetadata = try generateWallpaperMetadata(imageMetadatas: imageMetadatas, lightIndex: config.lightIndex, darkIndex: config.darkIndex)
    let destinationData = NSMutableData()
    guard let destination = CGImageDestinationCreateWithData(destinationData, AVFileType.heic as CFString, imageMetadatas.count, nil) else {
        throw DWBuilderError.HEICCreatingFailed
    }
    for (index, imageMetadata) in imageMetadatas.enumerated() {
        guard let image = NSImage(contentsOf: imageMetadata.url) else {
            throw DWBuilderError.ImageNotFound(imageMetadata.url)
        }
        
        guard let cgImage = getCGImage(from: image) else {
            throw DWBuilderError.HEICCreatingFailed
        }
        
        if index == 0 {
            CGImageDestinationAddImageAndMetadata(destination, cgImage, wallpaperMetadata, options as CFDictionary)
        } else {
            CGImageDestinationAddImage(destination, cgImage, options as CFDictionary)
        }
    }
    guard CGImageDestinationFinalize(destination) else {
        throw DWBuilderError.HEICCreatingFailed
    }
    
    return destinationData as Data
}

private func getCGImage(from image: NSImage) -> CGImage? {
    guard let imageData = image.tiffRepresentation else { return nil }
    guard let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
    return CGImageSourceCreateImageAtIndex(sourceData, 0, nil)
}

private func generateWallpaperMetadata(imageMetadatas: [ImageMetadata], lightIndex: Int, darkIndex: Int) throws -> CGMutableImageMetadata {
    let imageMetadata = CGImageMetadataCreateMutable()
    let propertyList = try generatePropertyList(imageMetadatas: imageMetadatas, lightIndex: lightIndex, darkIndex: darkIndex)
    try appendDesktopProperties(to: imageMetadata, key: "solar", data: propertyList)
    
    return imageMetadata
}

private func appendDesktopProperties(to imageMetadata: CGMutableImageMetadata, key: String, data: Data) throws {
    guard CGImageMetadataRegisterNamespaceForPrefix(imageMetadata, "http://ns.apple.com/namespace/1.0/" as CFString, "apple_desktop" as CFString, nil) else {
        throw DWBuilderError.HEICCreatingFailed
    }
    
    let base64PropertyList = data.base64EncodedString()
    let imageMetadataTag = CGImageMetadataTagCreate("http://ns.apple.com/namespace/1.0/" as CFString, "apple_desktop" as CFString, key as CFString, CGImageMetadataType.string, base64PropertyList as CFTypeRef)
    
    guard CGImageMetadataSetTagWithPath(imageMetadata, nil, "apple_desktop:\(key)" as CFString, imageMetadataTag!) else {
        throw DWBuilderError.HEICCreatingFailed
    }
}

private func generatePropertyList(imageMetadatas: [ImageMetadata], lightIndex: Int, darkIndex: Int) throws -> Data {
    let sequenceItems = imageMetadatas.enumerated().map { (index, imageMetadata) -> WallpaperImage in
        let solarAngle = imageMetadata.solarAngle
        return WallpaperImage(altitude: solarAngle.altitude, azimuth: solarAngle.azimuth, imageIndex: index)
    }
    let appearance = Appearance(lightIndex: lightIndex, darkIndex: darkIndex)
    let wallpaper = Wallpaper(sequenceItems: sequenceItems, appearance: appearance)
    
    let propertyList = PropertyListEncoder()
    do {
        return try propertyList.encode(wallpaper)
    } catch {
        throw DWBuilderError.PropertyListEncodingFailed
    }
}
