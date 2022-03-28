//
//  TopStoriesResponse.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
struct NewsResponse : Codable {
    let responseStatus : String
    let newCopyright : String
    let newsResults : [Article]

    enum CodingKeys: String, CodingKey {
        case responseStatus = "status"
        case newCopyright = "copyright"
        case newsResults = "results"
    }
}
