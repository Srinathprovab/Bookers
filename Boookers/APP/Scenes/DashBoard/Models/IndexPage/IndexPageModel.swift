//
//  IndexPageModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


struct IndexPageModel : Codable {
    let image_path : String?
    let currency : String?
    let flight_top_destinations1 : [Flight_top_destinations1]?
    let top_dest_hotel : [Top_dest_hotel]?
    let perfect_holidays : [Perfect_holidays]?
    
    enum CodingKeys: String, CodingKey {
        
        case image_path = "image_path"
        case currency = "currency"
        case flight_top_destinations1 = "flight_top_destinations1"
        case top_dest_hotel = "top_dest_hotel"
        case perfect_holidays = "perfect_holidays"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        flight_top_destinations1 = try values.decodeIfPresent([Flight_top_destinations1].self, forKey: .flight_top_destinations1)
        top_dest_hotel = try values.decodeIfPresent([Top_dest_hotel].self, forKey: .top_dest_hotel)
        perfect_holidays = try values.decodeIfPresent([Perfect_holidays].self, forKey: .perfect_holidays)
    }
    
}
