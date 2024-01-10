//
//  VocherModel.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import Foundation


struct VocherModel : Codable {
    let data : VocherModelDetails?
    let cancelltion_policy : String?
  //  let baggageAllowance : [BaggageAllowance]?
    let item : String?
    let flight_details : Flight_details?
    let price : Price1?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case cancelltion_policy = "cancelltion_policy"
   //     case baggageAllowance = "BaggageAllowance"
        case item = "item"
        case flight_details = "flight_details"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(VocherModelDetails.self, forKey: .data)
        cancelltion_policy = try values.decodeIfPresent(String.self, forKey: .cancelltion_policy)
   //     baggageAllowance = try values.decodeIfPresent([BaggageAllowance].self, forKey: .baggageAllowance)
        item = try values.decodeIfPresent(String.self, forKey: .item)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        price = try values.decodeIfPresent(Price1.self, forKey: .price)
    }
    
}






struct Price1 : Codable {
    
    let api_currency : String?
    let api_total_display_fare : Double?
    
    
    enum CodingKeys: String, CodingKey {
        case api_currency = "api_currency"
        case api_total_display_fare = "api_total_display_fare"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
        api_total_display_fare = try values.decodeIfPresent(Double.self, forKey: .api_total_display_fare)
    }
    
}
