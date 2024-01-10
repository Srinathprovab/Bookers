//
//  PreProcessBookingModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation


struct PreProcessBookingModel : Codable {
    let form_params : Form_params?
    let form_url : String?
    let status : Bool?
    let msg : String?
    let promo_info : [Promo_info]?

    enum CodingKeys: String, CodingKey {

        case form_params = "form_params"
        case form_url = "form_url"
        case status = "status"
        case msg = "msg"
        case promo_info = "promo_info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        promo_info = try values.decodeIfPresent([Promo_info].self, forKey: .promo_info)
    }

}
