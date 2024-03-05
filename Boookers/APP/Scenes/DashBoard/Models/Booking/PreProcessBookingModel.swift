//
//  PreProcessBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


struct PreProcessBookingModel : Codable {
    let form_params : Form_params?
    let booking_source : String?
    let access_key : String?
    let search_id : String?
    let hit_url : String?

    enum CodingKeys: String, CodingKey {

        case form_params = "form_params"
        case booking_source = "booking_source"
        case access_key = "access_key"
        case search_id = "search_id"
        case hit_url = "hit_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
    }

}
