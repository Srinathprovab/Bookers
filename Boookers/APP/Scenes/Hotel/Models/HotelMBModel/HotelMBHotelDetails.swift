//
//  HotelMBHotelDetails.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation


struct HotelMBHotelDetails : Codable {
    let address : String?
    let thumb_image : String?
    let checkOut : String?
    let image : String?
    let price : String?
    let star_rating : Int?
    let checkIn : String?
    let hotel_code : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case address = "address"
        case thumb_image = "thumb_image"
        case checkOut = "checkOut"
        case image = "image"
        case price = "price"
        case star_rating = "star_rating"
        case checkIn = "checkIn"
        case hotel_code = "hotel_code"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        checkOut = try values.decodeIfPresent(String.self, forKey: .checkOut)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        checkIn = try values.decodeIfPresent(String.self, forKey: .checkIn)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
