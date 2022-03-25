//
//  TopStoriesResponse.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
struct TopStoriesResponse : Codable {
    let status : String?
    let copyright : String?
    let section : String?
    let last_updated : String?
    let num_results : Int?
    let results : [TopStories]?

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case section
        case last_updated
        case num_results
        case results
    }
}
