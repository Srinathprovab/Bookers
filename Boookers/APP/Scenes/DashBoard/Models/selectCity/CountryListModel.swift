//
//  CountryListModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


struct CountryListModel : Codable {
    let country_list : [Country_list]?

    enum CodingKeys: String, CodingKey {

        case country_list = "country_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country_list = try values.decodeIfPresent([Country_list].self, forKey: .country_list)
    }

}
