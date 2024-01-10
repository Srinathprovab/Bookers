//
//  HotelListModel.swift
//  KuwaitWays
//
//  Created by FCI on 02/05/23.
//

import Foundation


struct HotelListModel : Codable {
    let booking_source : String?
    let search_id : Int?
    let total_count : Int?
    let filters_display : FiltersDisplay?
    let offset : Int?
    let status : Int?
    let filter_result_count : Int?
    let data : HotelListModelData?
    let total_result_count : Int?
    let msg : String?
    let session_expiry_details : Session_expiry_details?
    
    enum CodingKeys: String, CodingKey {
        
        case booking_source = "booking_source"
        case search_id = "search_id"
        case total_count = "total_count"
        case filters_display = "filters_display"
        case offset = "offset"
        case status = "status"
        case filter_result_count = "filter_result_count"
        case data = "data"
        case total_result_count = "total_result_count"
        case msg = "msg"
        case session_expiry_details = "session_expiry_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        total_count = try values.decodeIfPresent(Int.self, forKey: .total_count)
        filters_display = try values.decodeIfPresent(FiltersDisplay.self, forKey: .filters_display)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        data = try values.decodeIfPresent(HotelListModelData.self, forKey: .data)
        total_result_count = try values.decodeIfPresent(Int.self, forKey: .total_result_count)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }
    
}



struct HotelListModelData : Codable {
    let hotelSearchResult : [HotelSearchResult]?
    let source_result_count : Int?
    let filter_result_count : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case hotelSearchResult = "HotelSearchResult"
        case source_result_count = "source_result_count"
        case filter_result_count = "filter_result_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hotelSearchResult = try values.decodeIfPresent([HotelSearchResult].self, forKey: .hotelSearchResult)
        source_result_count = try values.decodeIfPresent(Int.self, forKey: .source_result_count)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
    }
    
}
