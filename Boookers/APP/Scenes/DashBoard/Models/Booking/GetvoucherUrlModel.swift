//
//  GetvoucherUrlModel.swift
//  KuwaitWays
//
//  Created by FCI on 31/05/23.
//

import Foundation

struct GetvoucherUrlModel : Codable {
    
    let Status : Bool?
    let msg : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case Status = "Status"
        case msg = "msg"
        case url = "URL"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Status = try values.decodeIfPresent(Bool.self, forKey: .Status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        
    }

}
