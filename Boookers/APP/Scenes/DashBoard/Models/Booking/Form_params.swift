
import Foundation
struct Form_params : Codable {
	let promocode_discount_val : String?
	let promocode_discount_type : String?
	let token_key : String?
	let booking_source : String?
	let booking_id : String?
	let search_id : String?

	enum CodingKeys: String, CodingKey {

		case promocode_discount_val = "promocode_discount_val"
		case promocode_discount_type = "promocode_discount_type"
		case token_key = "token_key"
		case booking_source = "booking_source"
		case booking_id = "booking_id"
		case search_id = "search_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		promocode_discount_val = try values.decodeIfPresent(String.self, forKey: .promocode_discount_val)
		promocode_discount_type = try values.decodeIfPresent(String.self, forKey: .promocode_discount_type)
		token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
		booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
		booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
		search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
	}

}
