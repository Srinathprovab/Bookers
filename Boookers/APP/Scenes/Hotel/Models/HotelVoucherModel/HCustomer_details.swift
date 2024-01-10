//
//  HCustomer_details.swift
//  KuwaitWays
//
//  Created by FCI on 21/09/23.
//

import Foundation

struct HCustomer_details : Codable {
    let passport_issuing_country : String?
    let app_reference : String?
    let room_id : String?
    let phone : String?
    let age : String?
    let passenger_nationality : String?
    let status : String?
    let middle_name : String?
    let title : String?
    let passport_number : String?
    let first_name : String?
    let origin : String?
    let attributes : String?
    let pax_type : String?
    let last_name : String?
    let email : String?
    let date_of_birth : String?
    let passport_expiry_date : String?

    enum CodingKeys: String, CodingKey {

        case passport_issuing_country = "passport_issuing_country"
        case app_reference = "app_reference"
        case room_id = "room_id"
        case phone = "phone"
        case age = "age"
        case passenger_nationality = "passenger_nationality"
        case status = "status"
        case middle_name = "middle_name"
        case title = "title"
        case passport_number = "passport_number"
        case first_name = "first_name"
        case origin = "origin"
        case attributes = "attributes"
        case pax_type = "pax_type"
        case last_name = "last_name"
        case email = "email"
        case date_of_birth = "date_of_birth"
        case passport_expiry_date = "passport_expiry_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        room_id = try values.decodeIfPresent(String.self, forKey: .room_id)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        passenger_nationality = try values.decodeIfPresent(String.self, forKey: .passenger_nationality)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        middle_name = try values.decodeIfPresent(String.self, forKey: .middle_name)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
        pax_type = try values.decodeIfPresent(String.self, forKey: .pax_type)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        passport_expiry_date = try values.decodeIfPresent(String.self, forKey: .passport_expiry_date)
    }

}
