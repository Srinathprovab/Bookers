//
//  Flight_search_hit_url_Model.swift
//  Boookers
//
//  Created by FCI on 16/02/24.
//

import Foundation

struct Flight_search_hit_url_Model : Codable {
    let flight_search_params : Flight_search_params?
    let active_booking_source : [String]?
    let hit_url : [String]?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case flight_search_params = "flight_search_params"
        case active_booking_source = "active_booking_source"
        case hit_url = "hit_url"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flight_search_params = try values.decodeIfPresent(Flight_search_params.self, forKey: .flight_search_params)
        active_booking_source = try values.decodeIfPresent([String].self, forKey: .active_booking_source)
        hit_url = try values.decodeIfPresent([String].self, forKey: .hit_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}

