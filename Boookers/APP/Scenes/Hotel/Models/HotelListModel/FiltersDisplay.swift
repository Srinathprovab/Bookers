//
//  FiltersDisplay.swift
//  KuwaitWays
//
//  Created by FCI on 01/10/23.
//

import Foundation

struct FiltersDisplay : Codable {
    let p : P?
    let currency : Currency?
    let loc : [Loc]?
    let star : [Star]?
    let a_type : [A_type]?
    let facility : [Facility]?

    enum CodingKeys: String, CodingKey {

        case p = "p"
        case currency = "currency"
        case loc = "loc"
        case star = "star"
        case a_type = "a_type"
        case facility = "facility"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        p = try values.decodeIfPresent(P.self, forKey: .p)
        currency = try values.decodeIfPresent(Currency.self, forKey: .currency)
        loc = try values.decodeIfPresent([Loc].self, forKey: .loc)
        star = try values.decodeIfPresent([Star].self, forKey: .star)
        a_type = try values.decodeIfPresent([A_type].self, forKey: .a_type)
        facility = try values.decodeIfPresent([Facility].self, forKey: .facility)
    }

}
