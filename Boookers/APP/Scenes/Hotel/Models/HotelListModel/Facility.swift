

import Foundation
struct Facility : Codable {
	let cstr_inf : String?
	let icon : String?
	let c : Int?
	let v : String?
	let cstr : String?

	enum CodingKeys: String, CodingKey {

		case cstr_inf = "cstr_inf"
		case icon = "icon"
		case c = "c"
		case v = "v"
		case cstr = "cstr"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cstr_inf = try values.decodeIfPresent(String.self, forKey: .cstr_inf)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		c = try values.decodeIfPresent(Int.self, forKey: .c)
		v = try values.decodeIfPresent(String.self, forKey: .v)
		cstr = try values.decodeIfPresent(String.self, forKey: .cstr)
	}

}
