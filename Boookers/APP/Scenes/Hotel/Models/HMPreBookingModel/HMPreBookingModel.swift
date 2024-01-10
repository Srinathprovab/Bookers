//
//  HMPreBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation

struct HMPreBookingModel : Codable {
    let status : Bool?
    let msg : String?
    let form_url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case form_url = "form_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
    }

}



struct HMPreBookingData : Codable {
    let post_data : Post_data?

    enum CodingKeys: String, CodingKey {

        case post_data = "post_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        post_data = try values.decodeIfPresent(Post_data.self, forKey: .post_data)
    }

}
