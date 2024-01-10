//
//  AboutusModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation

struct AboutusModel : Codable {
   
    let data : AboutusData?
   
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(AboutusData.self, forKey: .data)
    }
    
}



struct AboutusData : Codable {
    
    let page_id : String?
    let module_name : String?
    let page_title : String?
    let page_description : String?
    let page_position : String?
    let page_keyword : String?
    let page_seo_title : String?
    let page_seo_keyword : String?
    let page_seo_description : String?
    let page_status : String?
    let module_type : String?
    
    enum CodingKeys: String, CodingKey {
        
        case page_id = "page_id"
        case module_name = "module_name"
        case page_title = "page_title"
        case page_description = "page_description"
        case page_position = "page_position"
        case page_keyword = "page_keyword"
        case page_seo_title = "page_seo_title"
        case page_seo_keyword = "page_seo_keyword"
        case page_seo_description = "page_seo_description"
        case page_status = "page_status"
        case module_type = "module_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page_id = try values.decodeIfPresent(String.self, forKey: .page_id)
        module_name = try values.decodeIfPresent(String.self, forKey: .module_name)
        page_title = try values.decodeIfPresent(String.self, forKey: .page_title)
        page_description = try values.decodeIfPresent(String.self, forKey: .page_description)
        page_position = try values.decodeIfPresent(String.self, forKey: .page_position)
        page_keyword = try values.decodeIfPresent(String.self, forKey: .page_keyword)
        page_seo_title = try values.decodeIfPresent(String.self, forKey: .page_seo_title)
        page_seo_keyword = try values.decodeIfPresent(String.self, forKey: .page_seo_keyword)
        page_seo_description = try values.decodeIfPresent(String.self, forKey: .page_seo_description)
        page_status = try values.decodeIfPresent(String.self, forKey: .page_status)
        module_type = try values.decodeIfPresent(String.self, forKey: .module_type)
    }
    
}
