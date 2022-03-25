//
//  TopStories.swift
//  BankDemo
//
//  Created by Santanu on 18/03/2022.
//

import Foundation
struct TopStories : Codable {
    let section : String?
    let subsection : String?
    let title : String?
    let abstract : String?
    let url : String?
    let byline : String?
    let item_type : String?
    let updated_date : String?
    let created_date : String?
    let published_date : String?
    let material_type_facet : String?
    let kicker : String?
    let des_facet : [String]?
    let org_facet : [String]?
    let per_facet : [String]?
    let geo_facet : [String]?
    let multimedia : [Multimedia]?
    let short_url : String?

    enum CodingKeys: String, CodingKey {

        case section
        case subsection
        case title
        case abstract
        case url
        case byline
        case item_type
        case updated_date
        case created_date
        case published_date
        case material_type_facet
        case kicker
        case des_facet
        case org_facet
        case per_facet
        case geo_facet
        case multimedia
        case short_url
    }

}
