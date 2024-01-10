//
//  ContactusModel.swift
//  KuwaitWays
//
//  Created by FCI on 21/12/23.
//

import Foundation
struct ContactusModel : Codable {
    let status : Int?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
