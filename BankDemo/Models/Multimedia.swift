//
//  Multimedia.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
struct Multimedia : Codable {
    let url : String?
    let format : String?
    let height : Int?
    let width : Int?
    let type : String?
    let subtype : String?
    let caption : String?
    let copyright : String?

    enum CodingKeys: String, CodingKey {

        case url
        case format
        case height
        case width
        case type
        case subtype
        case caption
        case copyright
    }
}
