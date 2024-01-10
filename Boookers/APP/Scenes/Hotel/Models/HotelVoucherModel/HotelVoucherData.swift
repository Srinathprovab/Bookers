//
//  HotelVoucherData.swift
//  KuwaitWays
//
//  Created by FCI on 21/09/23.
//

import Foundation

struct HotelVoucherData : Codable {
    let booking_details : [HBooking_details]?
    let agent_details : String?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
        case agent_details = "agent_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([HBooking_details].self, forKey: .booking_details)
        agent_details = try values.decodeIfPresent(String.self, forKey: .agent_details)
    }

}
