//
//  FlightDetailsModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


struct FlightDetailsModel : Codable {
    let flight_details : Flight_details?
    let price : Price?
    let paxwise_price : Paxwise_price?
    let access_key : String?
    let faretype : Bool?
    let booking_source : String?
    let search_id : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case flight_details = "flight_details"
        case price = "price"
        case paxwise_price = "paxwise_price"
        case access_key = "access_key"
        case faretype = "faretype"
        case booking_source = "booking_source"
        case search_id = "search_id"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        paxwise_price = try values.decodeIfPresent(Paxwise_price.self, forKey: .paxwise_price)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        faretype = try values.decodeIfPresent(Bool.self, forKey: .faretype)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}



