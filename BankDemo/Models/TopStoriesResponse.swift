//
//  TopStoriesResponse.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
struct TopStoriesResponse : Codable {
    let responseStatus : String?
    let newCopyright : String?
    let newsResults : [TopStorie]?

    enum CodingKeys: String, CodingKey {
        case responseStatus = "status"
        case newCopyright = "copyright"
        case newsResults = "results"
    }
}
