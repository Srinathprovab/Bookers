//
//  FlightDetailsModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


struct FlightDetailsModel : Codable {
    let status : Bool?
    let journeySummary : [JourneySummary]?
    let flightDetails : [[FlightDetails]]?
    let priceDetails : PriceDetails?
    let fareRulehtml : [FareRulehtml]?
    let fare_rule_ref_key : String?
    let farerulesref_content : String?
    let baggageAllowance : [BaggageAllowance]?
    let booking_source : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case journeySummary = "journeySummary"
        case flightDetails = "flightDetails"
        case priceDetails = "priceDetails"
        case fareRulehtml = "fareRulehtml"
        case fare_rule_ref_key = "fare_rule_ref_key"
        case farerulesref_content = "farerulesref_content"
        case baggageAllowance = "BaggageAllowance"
        case booking_source = "booking_source"
        
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        journeySummary = try values.decodeIfPresent([JourneySummary].self, forKey: .journeySummary)
        flightDetails = try values.decodeIfPresent([[FlightDetails]].self, forKey: .flightDetails)
        priceDetails = try values.decodeIfPresent(PriceDetails.self, forKey: .priceDetails)
        fareRulehtml = try values.decodeIfPresent([FareRulehtml].self, forKey: .fareRulehtml)
        fare_rule_ref_key = try values.decodeIfPresent(String.self, forKey: .fare_rule_ref_key)
        farerulesref_content = try values.decodeIfPresent(String.self, forKey: .farerulesref_content)
        baggageAllowance = try values.decodeIfPresent([BaggageAllowance].self, forKey: .baggageAllowance)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
    }
    
}
