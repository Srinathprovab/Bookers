//
//  MJ_flight_list.swift
//  KuwaitWays
//
//  Created by FCI on 12/07/23.
//

import Foundation

struct MJ_flight_list : Codable {
    
    let totalPrice : String?
    let basePrice : String?
    let taxes : String?
    let totalPrice_API : String?
    let aPICurrencyType : String?
    let sITECurrencyType : String?
    let fareType : String?
    let flight_details : MFlight_details?
    let selectedResult : String?
    let access_key : String?
    let price : Price?
    
    enum CodingKeys: String, CodingKey {
        
        case totalPrice = "TotalPrice"
        case basePrice = "BasePrice"
        case taxes = "Taxes"
        case totalPrice_API = "TotalPrice_API"
        case aPICurrencyType = "APICurrencyType"
        case sITECurrencyType = "sITECurrencyType"
        case fareType = "FareType"
        case flight_details = "flight_details"
        case selectedResult = "selectedResult"
        case access_key = "access_key"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        flight_details = try values.decodeIfPresent(MFlight_details.self, forKey: .flight_details)
        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        price = try values.decodeIfPresent(Price.self, forKey: .price)

    }
    
}
