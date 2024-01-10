//
//  MulticityModel.swift
//  KuwaitWays
//
//  Created by FCI on 12/07/23.
//

import Foundation

struct MulticityModel : Codable {
    let status : Int?
    let data : MulticityModelData?
    let session_expiry_details : Session_expiry_details?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case session_expiry_details = "session_expiry_details"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(MulticityModelData.self, forKey: .data)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
