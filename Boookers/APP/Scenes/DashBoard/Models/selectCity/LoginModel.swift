//
//  LoginModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation


struct LoginModel : Codable {
    let data : String?
    let first_name : String?
    let image : String?
    let last_name : String?
    let country_code : String?
    let phone : String?
    let user_id : String?
    let status : Bool?
    let email : String?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case first_name = "first_name"
        case image = "image"
        case last_name = "last_name"
        case country_code = "country_code"
        case phone = "phone"
        case user_id = "user_id"
        case status = "status"
        case email = "email"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}


