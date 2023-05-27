//
//  Color.swift
//  ColorPalette
//
//  Created by Yuchen Guo on 4/6/23.
//

import Foundation

class Color: CustomDebugStringConvertible, Codable {
    var debugDescription: String {
        return "Color(name: \(self.colorChineseName), englishName: \(self.colorEnglishName), hexValue: \(self.colorHexValue)"
    }
    
    var colorChineseName: String
    var colorEnglishName: String
    var colorHexValue: String
    var imageUrl: String
    //var confirmedSighting: Bool = false
    var confirmedSave: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case colorChineseName, colorEnglishName, colorHexValue, imageUrl
    }
    
    // call implementation
    init(_ colorChineseName: String, _ colorEnglishName: String, _ colorHexValue: String, _ imageUrl: String) {
        self.colorChineseName = colorChineseName
        self.colorEnglishName = colorEnglishName
        self.colorHexValue = colorHexValue
        self.imageUrl = imageUrl
        //self.imageUrl = FileManager.default.urls(for: <#T##FileManager.SearchPathDirectory#>, in: <#T##FileManager.SearchPathDomainMask#>)
    }
}

struct colorResult: Codable {
    let colors: [Color]
}
