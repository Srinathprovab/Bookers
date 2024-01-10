//
//  MFlight_details.swift
//  KuwaitWays
//
//  Created by FCI on 15/07/23.
//

import Foundation

struct MFlight_details : Codable {
    let summary : [MSummary]?
    let details : [[Details]]?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
        case details = "details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([MSummary].self, forKey: .summary)
        details = try values.decodeIfPresent([[Details]].self, forKey: .details)
    }

}
