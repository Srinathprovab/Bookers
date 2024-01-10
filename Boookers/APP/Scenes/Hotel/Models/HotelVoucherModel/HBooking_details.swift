//
//  HBooking_details.swift
//  KuwaitWays
//
//  Created by FCI on 21/09/23.
//

import Foundation

struct HBooking_details : Codable {
    let lead_pax_name : String?
    let parent_id : String?
    let reward_amount : String?
    let admin_lead_pax_name : String?
    let alternate_number : String?
    let cancellation_details : String?
    let booked_by_id : String?
    let app_reference : String?
    let lead_pax_phone_number : String?
    let convinence_value : String?
    let search_params : String?
    let child_count : Int?
    let admin_markup : Int?
    let itinerary_details : [HItinerary_details]?
    let currency : String?
    let status : String?
    let currency_conversion_rate : String?
    let hotel_address : String?
    let convinence_amount : String?
    let search_id : String?
    let customer_details : [HCustomer_details]?
    let hotel_check_in : String?
    let domain_logo : String?
    let booking_reference : String?
    let hotel_image : String?
    let cutomer_country : String?
    let promo_code : String?
    let reward_points : String?
    let origin : String?
    let domain_origin : String?
    let use_limit : String?
    let theme_id : String?
    let email : String?
    let lead_pax_email : String?
    let fare : Double?
    let hotel_phone_number : String?
    let convinence_value_type : String?
    let hotel_code : String?
    let hotel_cancelation_policy : [Hotel_cancelation_policy]?
    let admin_buying_price : Double?
    let domain_key : String?
    let hotel_name : String?
    let total_rooms : Int?
    let cutomer_address : String?
    let agent_markup : Int?
    let hotel_location : String?
    let voucher_date : String?
    let domain_name : String?
    let cashback_status : String?
    let created_datetime : String?
    let booking_id : String?
    let booking_source : String?
    let domain_ip : String?
    let cutomer_zipcode : String?
    let hotel_check_out : String?
    let hotel_email : String?
    let phone_number : String?
    let total_nights : Int?
    let confirmation_reference : String?
    let star_rating : String?
    let adult_count : Int?
    let payment_mode : String?
    let cutomer_city : String?
    let convinence_per_pax : String?
    let deal_code_amount : String?
    let grand_total : Double?
    let created_by_id : String?
    let deal_code : String?
    let reward_earned : String?
    let discount : String?
    let agent_buying_price : Int?

    enum CodingKeys: String, CodingKey {

        case lead_pax_name = "lead_pax_name"
        case parent_id = "parent_id"
        case reward_amount = "reward_amount"
        case admin_lead_pax_name = "admin_lead_pax_name"
        case alternate_number = "alternate_number"
        case cancellation_details = "cancellation_details"
        case booked_by_id = "booked_by_id"
        case app_reference = "app_reference"
        case lead_pax_phone_number = "lead_pax_phone_number"
        case convinence_value = "convinence_value"
        case search_params = "search_params"
        case child_count = "child_count"
        case admin_markup = "admin_markup"
        case itinerary_details = "itinerary_details"
        case currency = "currency"
        case status = "status"
        case currency_conversion_rate = "currency_conversion_rate"
        case hotel_address = "hotel_address"
        case convinence_amount = "convinence_amount"
        case search_id = "search_id"
        case customer_details = "customer_details"
        case hotel_check_in = "hotel_check_in"
        case domain_logo = "domain_logo"
        case booking_reference = "booking_reference"
        case hotel_image = "hotel_image"
        case cutomer_country = "cutomer_country"
        case promo_code = "promo_code"
        case reward_points = "reward_points"
        case origin = "origin"
        case domain_origin = "domain_origin"
        case use_limit = "use_limit"
        case theme_id = "theme_id"
        case email = "email"
        case lead_pax_email = "lead_pax_email"
        case fare = "fare"
        case hotel_phone_number = "hotel_phone_number"
        case convinence_value_type = "convinence_value_type"
        case hotel_code = "hotel_code"
        case hotel_cancelation_policy = "hotel_cancelation_policy"
        case admin_buying_price = "admin_buying_price"
        case domain_key = "domain_key"
        case hotel_name = "hotel_name"
        case total_rooms = "total_rooms"
        case cutomer_address = "cutomer_address"
        case agent_markup = "agent_markup"
        case hotel_location = "hotel_location"
        case voucher_date = "voucher_date"
        case domain_name = "domain_name"
        case cashback_status = "cashback_status"
        case created_datetime = "created_datetime"
        case booking_id = "booking_id"
        case booking_source = "booking_source"
        case domain_ip = "domain_ip"
        case cutomer_zipcode = "cutomer_zipcode"
        case hotel_check_out = "hotel_check_out"
        case hotel_email = "hotel_email"
        case phone_number = "phone_number"
        case total_nights = "total_nights"
        case confirmation_reference = "confirmation_reference"
        case star_rating = "star_rating"
        case adult_count = "adult_count"
        case payment_mode = "payment_mode"
        case cutomer_city = "cutomer_city"
        case convinence_per_pax = "convinence_per_pax"
        case deal_code_amount = "deal_code_amount"
        case grand_total = "grand_total"
        case created_by_id = "created_by_id"
        case deal_code = "deal_code"
        case reward_earned = "reward_earned"
        case discount = "discount"
        case agent_buying_price = "agent_buying_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lead_pax_name = try values.decodeIfPresent(String.self, forKey: .lead_pax_name)
        parent_id = try values.decodeIfPresent(String.self, forKey: .parent_id)
        reward_amount = try values.decodeIfPresent(String.self, forKey: .reward_amount)
        admin_lead_pax_name = try values.decodeIfPresent(String.self, forKey: .admin_lead_pax_name)
        alternate_number = try values.decodeIfPresent(String.self, forKey: .alternate_number)
        cancellation_details = try values.decodeIfPresent(String.self, forKey: .cancellation_details)
        booked_by_id = try values.decodeIfPresent(String.self, forKey: .booked_by_id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        lead_pax_phone_number = try values.decodeIfPresent(String.self, forKey: .lead_pax_phone_number)
        convinence_value = try values.decodeIfPresent(String.self, forKey: .convinence_value)
        search_params = try values.decodeIfPresent(String.self, forKey: .search_params)
        child_count = try values.decodeIfPresent(Int.self, forKey: .child_count)
        admin_markup = try values.decodeIfPresent(Int.self, forKey: .admin_markup)
        itinerary_details = try values.decodeIfPresent([HItinerary_details].self, forKey: .itinerary_details)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        currency_conversion_rate = try values.decodeIfPresent(String.self, forKey: .currency_conversion_rate)
        hotel_address = try values.decodeIfPresent(String.self, forKey: .hotel_address)
        convinence_amount = try values.decodeIfPresent(String.self, forKey: .convinence_amount)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        customer_details = try values.decodeIfPresent([HCustomer_details].self, forKey: .customer_details)
        hotel_check_in = try values.decodeIfPresent(String.self, forKey: .hotel_check_in)
        domain_logo = try values.decodeIfPresent(String.self, forKey: .domain_logo)
        booking_reference = try values.decodeIfPresent(String.self, forKey: .booking_reference)
        hotel_image = try values.decodeIfPresent(String.self, forKey: .hotel_image)
        cutomer_country = try values.decodeIfPresent(String.self, forKey: .cutomer_country)
        promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
        reward_points = try values.decodeIfPresent(String.self, forKey: .reward_points)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        domain_origin = try values.decodeIfPresent(String.self, forKey: .domain_origin)
        use_limit = try values.decodeIfPresent(String.self, forKey: .use_limit)
        theme_id = try values.decodeIfPresent(String.self, forKey: .theme_id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        lead_pax_email = try values.decodeIfPresent(String.self, forKey: .lead_pax_email)
        fare = try values.decodeIfPresent(Double.self, forKey: .fare)
        hotel_phone_number = try values.decodeIfPresent(String.self, forKey: .hotel_phone_number)
        convinence_value_type = try values.decodeIfPresent(String.self, forKey: .convinence_value_type)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        hotel_cancelation_policy = try values.decodeIfPresent([Hotel_cancelation_policy].self, forKey: .hotel_cancelation_policy)
        admin_buying_price = try values.decodeIfPresent(Double.self, forKey: .admin_buying_price)
        domain_key = try values.decodeIfPresent(String.self, forKey: .domain_key)
        hotel_name = try values.decodeIfPresent(String.self, forKey: .hotel_name)
        total_rooms = try values.decodeIfPresent(Int.self, forKey: .total_rooms)
        cutomer_address = try values.decodeIfPresent(String.self, forKey: .cutomer_address)
        agent_markup = try values.decodeIfPresent(Int.self, forKey: .agent_markup)
        hotel_location = try values.decodeIfPresent(String.self, forKey: .hotel_location)
        voucher_date = try values.decodeIfPresent(String.self, forKey: .voucher_date)
        domain_name = try values.decodeIfPresent(String.self, forKey: .domain_name)
        cashback_status = try values.decodeIfPresent(String.self, forKey: .cashback_status)
        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        domain_ip = try values.decodeIfPresent(String.self, forKey: .domain_ip)
        cutomer_zipcode = try values.decodeIfPresent(String.self, forKey: .cutomer_zipcode)
        hotel_check_out = try values.decodeIfPresent(String.self, forKey: .hotel_check_out)
        hotel_email = try values.decodeIfPresent(String.self, forKey: .hotel_email)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        total_nights = try values.decodeIfPresent(Int.self, forKey: .total_nights)
        confirmation_reference = try values.decodeIfPresent(String.self, forKey: .confirmation_reference)
        star_rating = try values.decodeIfPresent(String.self, forKey: .star_rating)
        adult_count = try values.decodeIfPresent(Int.self, forKey: .adult_count)
        payment_mode = try values.decodeIfPresent(String.self, forKey: .payment_mode)
        cutomer_city = try values.decodeIfPresent(String.self, forKey: .cutomer_city)
        convinence_per_pax = try values.decodeIfPresent(String.self, forKey: .convinence_per_pax)
        deal_code_amount = try values.decodeIfPresent(String.self, forKey: .deal_code_amount)
        grand_total = try values.decodeIfPresent(Double.self, forKey: .grand_total)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        deal_code = try values.decodeIfPresent(String.self, forKey: .deal_code)
        reward_earned = try values.decodeIfPresent(String.self, forKey: .reward_earned)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        agent_buying_price = try values.decodeIfPresent(Int.self, forKey: .agent_buying_price)
    }

}
