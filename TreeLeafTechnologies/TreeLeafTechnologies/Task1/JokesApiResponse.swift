//
//  ApiResponseDog.swift
//  TreeLeafTechnologies
//
//  Created by Preksha Dahal on 29/12/2023.
//

import Foundation
import ObjectMapper

struct Joke: Mappable {
    var type: String?
    var setup: String?
    var punchline: String?
    var id: Int?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        type <- map["type"]
        setup <- map["setup"]
        punchline <- map["punchline"]
        id <- map["id"]
    }
}
