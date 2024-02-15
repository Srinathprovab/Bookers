/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Sports_top_destinations : Codable {
	let id : String?
	let country : String?
	let event : String?
	let from_date : String?
	let to_date : String?
	let status : String?
	let created_at : String?
	let image : String?
	let updated_at : String?
	let country_id : String?
	let event_id : String?
	let url_sports : String?
	let hit_url : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case country = "country"
		case event = "event"
		case from_date = "from_date"
		case to_date = "to_date"
		case status = "status"
		case created_at = "created_at"
		case image = "image"
		case updated_at = "updated_at"
		case country_id = "country_id"
		case event_id = "event_id"
		case url_sports = "url_sports"
		case hit_url = "hit_url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		event = try values.decodeIfPresent(String.self, forKey: .event)
		from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
		to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
		event_id = try values.decodeIfPresent(String.self, forKey: .event_id)
		url_sports = try values.decodeIfPresent(String.self, forKey: .url_sports)
		hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
	}

}