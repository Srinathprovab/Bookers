//
//  HotelDetailsModel.swift
//  KuwaitWays
//
//  Created by FCI on 03/05/23.
//

import Foundation


struct HotelDetailsModel : Codable {
    let advertisement : [String]?
    let session_expiry_details : String?
    let hotel_search_params : Hotel_search_params?
    let currency_obj : Currency_obj?
    let hotel_details : Hotel_details?
    let active_booking_source : String?
    let status : Bool?
    let params : Params?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case advertisement = "advertisement"
        case session_expiry_details = "session_expiry_details"
        case hotel_search_params = "hotel_search_params"
        case currency_obj = "currency_obj"
        case hotel_details = "hotel_details"
        case active_booking_source = "active_booking_source"
        case status = "status"
        case params = "params"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        advertisement = try values.decodeIfPresent([String].self, forKey: .advertisement)
        session_expiry_details = try values.decodeIfPresent(String.self, forKey: .session_expiry_details)
        hotel_search_params = try values.decodeIfPresent(Hotel_search_params.self, forKey: .hotel_search_params)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
        active_booking_source = try values.decodeIfPresent(String.self, forKey: .active_booking_source)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        params = try values.decodeIfPresent(Params.self, forKey: .params)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
