//
//  FlightListModel.swift
//  Boookers
//
//  Created by FCI on 16/02/24.
//

import Foundation

struct FlightListModel : Codable {
    //  let data : [String]?
    let msg : String?
    let status : Int?
    let flight_result : [Flight_result]?
    let session_expiry_details : Session_expiry_details?
    let search_id : String?
    
    
    enum CodingKeys: String, CodingKey {
        
        //    case data = "data"
        case msg = "msg"
        case status = "status"
        case flight_result = "flight_result"
        case session_expiry_details = "session_expiry_details"
        case search_id = "search_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //    data = try values.decodeIfPresent([String].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        flight_result = try values.decodeIfPresent([Flight_result].self, forKey: .flight_result)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }
    
}
