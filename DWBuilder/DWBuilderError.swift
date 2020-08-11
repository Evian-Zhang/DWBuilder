//
//  DWBuilderError.swift
//  DWBuilder
//
//  Created by 张曙 on 2020/8/11.
//

import Foundation

enum DWBuilderError: Error {
    case PropertyListEncodingFailed
    case ImageNotFound(URL)
    case HEICCreatingFailed
}
