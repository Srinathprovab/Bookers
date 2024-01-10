

import Foundation
struct Format_ame : Codable {
	let ame : String?

	enum CodingKeys: String, CodingKey {

		case ame = "ame"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		ame = try values.decodeIfPresent(String.self, forKey: .ame)
	}

}
