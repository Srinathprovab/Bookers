
import Foundation
struct Form_params : Codable {
    let promocode_discount_val : String?
    let promocode_discount_type : String?

    enum CodingKeys: String, CodingKey {

        case promocode_discount_val = "promocode_discount_val"
        case promocode_discount_type = "promocode_discount_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        promocode_discount_val = try values.decodeIfPresent(String.self, forKey: .promocode_discount_val)
        promocode_discount_type = try values.decodeIfPresent(String.self, forKey: .promocode_discount_type)
    }

}
