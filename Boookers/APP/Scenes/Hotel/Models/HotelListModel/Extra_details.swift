

import Foundation
struct Extra_details : Codable {
	let category_code : String?
	let offers : Bool?
	let star_rating_text : String?

	enum CodingKeys: String, CodingKey {

		case category_code = "category_code"
		case offers = "offers"
		case star_rating_text = "star_rating_text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		category_code = try values.decodeIfPresent(String.self, forKey: .category_code)
		offers = try values.decodeIfPresent(Bool.self, forKey: .offers)
		star_rating_text = try values.decodeIfPresent(String.self, forKey: .star_rating_text)
	}

}
