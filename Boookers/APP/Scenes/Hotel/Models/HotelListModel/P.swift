

import Foundation
struct P : Codable {
	let max : Int?
	let min : Int?

	enum CodingKeys: String, CodingKey {

		case max = "max"
		case min = "min"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		max = try values.decodeIfPresent(Int.self, forKey: .max)
		min = try values.decodeIfPresent(Int.self, forKey: .min)
	}

}
