//
//  HItinerary_details.swift
//  KuwaitWays
//
//  Created by FCI on 21/09/23.
//

import Foundation

struct HItinerary_details : Codable {
    let app_reference : String?
    let location : String?
    let bed_type_code : String?
    let status : String?
    let total_fare : String?
    let admin_markup : String?
    let extraGuestCharge : String?
    let childCharge : String?
    let tax : String?
    let agentMarkUp : String?
    let tDS : String?
    let smoking_preference : String?
    let currency : String?
    let payment_status : String?
    let check_in : String?
    let origin : String?
    let room_type_name : String?
    let otherCharges : String?
    let agent_markup : String?
    let discount : String?
    let serviceTax : String?
    let check_out : String?
    let room_id : String?
    let roomPrice : String?
    let attributes : String?
    let agentCommission : String?
    let convenience_fee : String?

    enum CodingKeys: String, CodingKey {

        case app_reference = "app_reference"
        case location = "location"
        case bed_type_code = "bed_type_code"
        case status = "status"
        case total_fare = "total_fare"
        case admin_markup = "admin_markup"
        case extraGuestCharge = "ExtraGuestCharge"
        case childCharge = "ChildCharge"
        case tax = "Tax"
        case agentMarkUp = "AgentMarkUp"
        case tDS = "TDS"
        case smoking_preference = "smoking_preference"
        case currency = "currency"
        case payment_status = "payment_status"
        case check_in = "check_in"
        case origin = "origin"
        case room_type_name = "room_type_name"
        case otherCharges = "OtherCharges"
        case agent_markup = "agent_markup"
        case discount = "Discount"
        case serviceTax = "ServiceTax"
        case check_out = "check_out"
        case room_id = "room_id"
        case roomPrice = "RoomPrice"
        case attributes = "attributes"
        case agentCommission = "AgentCommission"
        case convenience_fee = "convenience_fee"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        bed_type_code = try values.decodeIfPresent(String.self, forKey: .bed_type_code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        total_fare = try values.decodeIfPresent(String.self, forKey: .total_fare)
        admin_markup = try values.decodeIfPresent(String.self, forKey: .admin_markup)
        extraGuestCharge = try values.decodeIfPresent(String.self, forKey: .extraGuestCharge)
        childCharge = try values.decodeIfPresent(String.self, forKey: .childCharge)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        agentMarkUp = try values.decodeIfPresent(String.self, forKey: .agentMarkUp)
        tDS = try values.decodeIfPresent(String.self, forKey: .tDS)
        smoking_preference = try values.decodeIfPresent(String.self, forKey: .smoking_preference)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        room_type_name = try values.decodeIfPresent(String.self, forKey: .room_type_name)
        otherCharges = try values.decodeIfPresent(String.self, forKey: .otherCharges)
        agent_markup = try values.decodeIfPresent(String.self, forKey: .agent_markup)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        serviceTax = try values.decodeIfPresent(String.self, forKey: .serviceTax)
        check_out = try values.decodeIfPresent(String.self, forKey: .check_out)
        room_id = try values.decodeIfPresent(String.self, forKey: .room_id)
        roomPrice = try values.decodeIfPresent(String.self, forKey: .roomPrice)
        attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
        agentCommission = try values.decodeIfPresent(String.self, forKey: .agentCommission)
        convenience_fee = try values.decodeIfPresent(String.self, forKey: .convenience_fee)
    }

}
