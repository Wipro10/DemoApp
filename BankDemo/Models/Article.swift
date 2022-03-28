//
//  TopStories.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
struct Article : Codable {
    let newSubsection : String
    let newsTitle : String
    let newsAbstract : String
    let newsWebUrl : String
    let newsByLine : String?
    let newsPublishedDate : String?
    let imageGallery : [ImageInformation]?

    enum CodingKeys: String, CodingKey {

        case newSubsection = "subsection"
        case newsTitle = "title"
        case newsAbstract = "abstract"
        case newsWebUrl = "url"
        case newsByLine = "byline"
        case newsPublishedDate = "published_date"
        case imageGallery = "multimedia"
    }

}
