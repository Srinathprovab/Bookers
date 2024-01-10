//
//  HotelVoucherModel.swift
//  KuwaitWays
//
//  Created by FCI on 21/09/23.
//

import Foundation


struct HotelVoucherModel : Codable {
    let mail : Int?
    let data : HotelVoucherData?
    let mail_status : Int?
    let hotel_static_info : Int?
    let hotel_county_name : String?
    let hotel_phone_number : String?

    enum CodingKeys: String, CodingKey {

        case mail = "mail"
        case data = "data"
        case mail_status = "mail_status"
        case hotel_static_info = "hotel_static_info"
        case hotel_county_name = "hotel_county_name"
        case hotel_phone_number = "hotel_phone_number"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mail = try values.decodeIfPresent(Int.self, forKey: .mail)
        data = try values.decodeIfPresent(HotelVoucherData.self, forKey: .data)
        mail_status = try values.decodeIfPresent(Int.self, forKey: .mail_status)
        hotel_static_info = try values.decodeIfPresent(Int.self, forKey: .hotel_static_info)
        hotel_county_name = try values.decodeIfPresent(String.self, forKey: .hotel_county_name)
        hotel_phone_number = try values.decodeIfPresent(String.self, forKey: .hotel_phone_number)
    }

}
