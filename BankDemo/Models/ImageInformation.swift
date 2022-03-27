//
//  Multimedia.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
struct ImageInformation : Codable {
    let imageUrl : String
    let imageFormat : String
    let imageHeight : Int
    let imageWidth : Int
    let imageType : String
    let imageCopyright : String

    enum CodingKeys: String, CodingKey {

        case imageUrl = "url"
        case imageFormat = "format"
        case imageHeight = "height"
        case imageWidth = "width"
        case imageType = "type"
        case imageCopyright = "copyright"
    }
}
