//
//  MobileBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation



struct MobileBookingModel : Codable {
    //   let converted_currency_rate : Int?
    let tmp_flight_pre_booking_id : String?
    let status : Int?
    let meal_list : [Meal_list]?
    //    let flight_terms_cancellation_policy : String?
    //    let pre_booking_params : Pre_booking_params?
    //    let reward_earned : Int?
    //    let total_price_with_rewards : Int?
    let special_allowance : [Special_allowance]?
    //    let session_expiry_details : Session_expiry_details?
    //    let convenience_fees : Int?
    let access_key_tp : String?
    //    let pax_details : Bool?
    let booking_source : String?
    let priceDetails : PriceDetails?
    //    let msg : String?
    //    let total_price : Double?
    //    let travel_date_diff : String?
    let active_payment_options : [String]?
    //    let reward_usable : Int?
    
    enum CodingKeys: String, CodingKey {
        
        //      case converted_currency_rate = "converted_currency_rate"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        //
        case status = "status"
        case meal_list = "meal_list"
        //        case flight_terms_cancellation_policy = "flight_terms_cancellation_policy"
        //        case pre_booking_params = "pre_booking_params"
        //        case reward_earned = "reward_earned"
        //        case total_price_with_rewards = "total_price_with_rewards"
        case special_allowance = "special_allowance"
        //        case session_expiry_details = "session_expiry_details"
        //        case convenience_fees = "convenience_fees"
        case access_key_tp = "access_key_tp"
        //        case pax_details = "pax_details"
        case booking_source = "booking_source"
        case priceDetails = "priceDetails"
        //        case msg = "msg"
        //        case total_price = "total_price"
        //        case travel_date_diff = "travel_date_diff"
        case active_payment_options = "active_payment_options"
        //        case reward_usable = "reward_usable"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //       converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        tmp_flight_pre_booking_id = try values.decodeIfPresent(String.self, forKey: .tmp_flight_pre_booking_id)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        meal_list = try values.decodeIfPresent([Meal_list].self, forKey: .meal_list)
        //        flight_terms_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .flight_terms_cancellation_policy)
        //        pre_booking_params = try values.decodeIfPresent(Pre_booking_params.self, forKey: .pre_booking_params)
        //        reward_earned = try values.decodeIfPresent(Int.self, forKey: .reward_earned)
        //        total_price_with_rewards = try values.decodeIfPresent(Int.self, forKey: .total_price_with_rewards)
        special_allowance = try values.decodeIfPresent([Special_allowance].self, forKey: .special_allowance)
        //        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        //        convenience_fees = try values.decodeIfPresent(Int.self, forKey: .convenience_fees)
        access_key_tp = try values.decodeIfPresent(String.self, forKey: .access_key_tp)
        //        pax_details = try values.decodeIfPresent(Bool.self, forKey: .pax_details)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        priceDetails = try values.decodeIfPresent(PriceDetails.self, forKey: .priceDetails)
        //        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        //        total_price = try values.decodeIfPresent(Double.self, forKey: .total_price)
        //        travel_date_diff = try values.decodeIfPresent(String.self, forKey: .travel_date_diff)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        //        reward_usable = try values.decodeIfPresent(Int.self, forKey: .reward_usable)
    }
    
}


