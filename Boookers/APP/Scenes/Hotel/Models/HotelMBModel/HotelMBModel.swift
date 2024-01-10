//
//  HotelMBModel.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation


struct HotelMBModel : Codable {
    let status : Int?
    let msg : String?
    let data : HotelMBData?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(HotelMBData.self, forKey: .data)
    }
    
}



struct HotelMBData : Codable {
    
    let discount : Int?
    let payment_booking_source : String?
    let booking_source : String?
    let converted_currency_rate : Int?
    let payment_method : String?
    let hotel_details : HotelMBHotelDetails?
    let convenience_fees : Int?
    let room_paxes_details : [Room_paxes_details]?
    let tax_service_sum : Int?
    let pre_booking_cancellation_policy : Pre_booking_cancellation_policy?
    let hotel_base_price : Double?
    let currency_obj : Currency_obj?
    let search_data : HotelMBSearchData?
    let token : String?
    let total_price : String?
    let reward_earned : Int?
    let reward_usable : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case discount = "discount"
        case payment_booking_source = "payment_booking_source"
        case booking_source = "booking_source"
        case converted_currency_rate = "converted_currency_rate"
        case payment_method = "payment_method"
        case hotel_details = "hotel_details"
        case convenience_fees = "convenience_fees"
        case room_paxes_details = "room_paxes_details"
        case tax_service_sum = "tax_service_sum"
        case pre_booking_cancellation_policy = "pre_booking_cancellation_policy"
        case hotel_base_price = "hotel_base_price"
        case currency_obj = "currency_obj"
        case search_data = "search_data"
        case token = "token"
        case total_price = "total_price"
        case reward_earned = "reward_earned"
        case reward_usable = "reward_usable"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        payment_booking_source = try values.decodeIfPresent(String.self, forKey: .payment_booking_source)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
        hotel_details = try values.decodeIfPresent(HotelMBHotelDetails.self, forKey: .hotel_details)
        convenience_fees = try values.decodeIfPresent(Int.self, forKey: .convenience_fees)
        room_paxes_details = try values.decodeIfPresent([Room_paxes_details].self, forKey: .room_paxes_details)
        tax_service_sum = try values.decodeIfPresent(Int.self, forKey: .tax_service_sum)
        pre_booking_cancellation_policy = try values.decodeIfPresent(Pre_booking_cancellation_policy.self, forKey: .pre_booking_cancellation_policy)
        hotel_base_price = try values.decodeIfPresent(Double.self, forKey: .hotel_base_price)
        currency_obj = try values.decodeIfPresent(Currency_obj.self, forKey: .currency_obj)
        search_data = try values.decodeIfPresent(HotelMBSearchData.self, forKey: .search_data)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        total_price = try values.decodeIfPresent(String.self, forKey: .total_price)
        reward_earned = try values.decodeIfPresent(Int.self, forKey: .reward_earned)
        reward_usable = try values.decodeIfPresent(Int.self, forKey: .reward_usable)
    }
    
}
