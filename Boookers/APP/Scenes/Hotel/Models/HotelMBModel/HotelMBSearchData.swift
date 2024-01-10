//
//  HotelMBSearchData.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation


struct HotelMBSearchData : Codable {
    let adult_config : [String]?
    let nationality : String?
    let country_name : String?
    let from_date : String?
    let total_pax_count : Int?
    let hotel_destination : String?
    let hotel_checkin_date : String?
    let hotel_checkout_date : String?
    let total_adult_count : Int?
    let to_date : String?
    let is_domestic : Bool?
    let location : String?
    let room_count : Int?
    let search_id : Int?
    let total_child_count : Int?
    let lang : String?
    let city_name : String?
    let no_of_nights : Int?
    let child_config : [String]?

    enum CodingKeys: String, CodingKey {

        case adult_config = "adult_config"
        case nationality = "nationality"
        case country_name = "country_name"
        case from_date = "from_date"
        case total_pax_count = "total_pax_count"
        case hotel_destination = "hotel_destination"
        case hotel_checkin_date = "hotel_checkin_date"
        case hotel_checkout_date = "hotel_checkout_date"
        case total_adult_count = "total_adult_count"
        case to_date = "to_date"
        case is_domestic = "is_domestic"
        case location = "location"
        case room_count = "room_count"
        case search_id = "search_id"
        case total_child_count = "total_child_count"
        case lang = "lang"
        case city_name = "city_name"
        case no_of_nights = "no_of_nights"
        case child_config = "child_config"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult_config = try values.decodeIfPresent([String].self, forKey: .adult_config)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
        total_pax_count = try values.decodeIfPresent(Int.self, forKey: .total_pax_count)
        hotel_destination = try values.decodeIfPresent(String.self, forKey: .hotel_destination)
        hotel_checkin_date = try values.decodeIfPresent(String.self, forKey: .hotel_checkin_date)
        hotel_checkout_date = try values.decodeIfPresent(String.self, forKey: .hotel_checkout_date)
        total_adult_count = try values.decodeIfPresent(Int.self, forKey: .total_adult_count)
        to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        room_count = try values.decodeIfPresent(Int.self, forKey: .room_count)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        total_child_count = try values.decodeIfPresent(Int.self, forKey: .total_child_count)
        lang = try values.decodeIfPresent(String.self, forKey: .lang)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        child_config = try values.decodeIfPresent([String].self, forKey: .child_config)
    }

}
