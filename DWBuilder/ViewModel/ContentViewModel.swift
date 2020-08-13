//
//  ContentViewModel.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var imageMetadatas: [ImageMetadata] = []
    @Published var lightIndex = 1 // start from 1
    @Published var darkIndex = 1 // start from 1
    
    func exportImage() throws -> Data {
        try generateWallpaper(config: GeneratorConfig(lightIndex: self.lightIndex - 1, darkIndex: self.darkIndex - 1), imageMetadatas: self.imageMetadatas)
    }
}
