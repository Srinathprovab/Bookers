//
//  MobileBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation



struct MobileBookingModel : Codable {
    let active_payment_options : [String]?
    let total_passenger : Int?
    let booking_source : String?
    let price : Price?
    let pre_booking_params : String?
    let search_data : Search_data?
    let tmp_flight_pre_booking_id : String?
    let flight_data : Flight_data?
    let status : Bool?
    

    enum CodingKeys: String, CodingKey {

        case active_payment_options = "active_payment_options"
        case total_passenger = "total_passenger"
        case booking_source = "booking_source"
        case price = "price"
        case pre_booking_params = "pre_booking_params"
        case search_data = "search_data"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        case flight_data = "flight_data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        total_passenger = try values.decodeIfPresent(Int.self, forKey: .total_passenger)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        pre_booking_params = try values.decodeIfPresent(String.self, forKey: .pre_booking_params)
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        tmp_flight_pre_booking_id = try values.decodeIfPresent(String.self, forKey: .tmp_flight_pre_booking_id)
        flight_data = try values.decodeIfPresent(Flight_data.self, forKey: .flight_data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}


