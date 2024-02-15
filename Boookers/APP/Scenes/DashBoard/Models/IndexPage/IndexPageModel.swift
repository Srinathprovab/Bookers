//
//  IndexPageModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


struct IndexPageModel : Codable {
    let sports_top_destinations : [Sports_top_destinations]?
    let flight_top_destinations : [Flight_top_destinations]?
    let hotel_top_destination : [Hotel_top_destination]?
    let promo_list : [Promo_list]?
    let holiday_top_destinations : [Holiday_top_destinations]?
    let security_check : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case sports_top_destinations = "sports_top_destinations"
        case flight_top_destinations = "flight_top_destinations"
        case hotel_top_destination = "hotel_top_destination"
        case promo_list = "promo_list"
        case holiday_top_destinations = "holiday_top_destinations"
        case security_check = "security_check"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sports_top_destinations = try values.decodeIfPresent([Sports_top_destinations].self, forKey: .sports_top_destinations)
        flight_top_destinations = try values.decodeIfPresent([Flight_top_destinations].self, forKey: .flight_top_destinations)
        hotel_top_destination = try values.decodeIfPresent([Hotel_top_destination].self, forKey: .hotel_top_destination)
        promo_list = try values.decodeIfPresent([Promo_list].self, forKey: .promo_list)
        holiday_top_destinations = try values.decodeIfPresent([Holiday_top_destinations].self, forKey: .holiday_top_destinations)
        security_check = try values.decodeIfPresent(String.self, forKey: .security_check)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}
