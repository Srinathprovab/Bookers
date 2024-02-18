//
//  pre_flight_search_Model.swift
//  Boookers
//
//  Created by FCI on 16/02/24.
//

import Foundation
struct pre_flight_search_Model : Codable {
    let status : Bool?
    let hit_url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case hit_url = "hit_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
    }

}
