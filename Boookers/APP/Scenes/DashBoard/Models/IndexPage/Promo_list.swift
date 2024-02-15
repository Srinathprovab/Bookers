/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Promo_list : Codable {
	let origin : String?
	let module : String?
	let promo_code : String?
	let description : String?
	let amt_min : String?
	let value : String?
	let value_type : String?
	let use_type : String?
	let limitation : String?
	let start_date : String?
	let expiry_date : String?
	let status : String?
	let created_by_id : String?
	let created_datetime : String?
	let image_path : String?
	let publish_status : String?

	enum CodingKeys: String, CodingKey {

		case origin = "origin"
		case module = "module"
		case promo_code = "promo_code"
		case description = "description"
		case amt_min = "amt_min"
		case value = "value"
		case value_type = "value_type"
		case use_type = "use_type"
		case limitation = "limitation"
		case start_date = "start_date"
		case expiry_date = "expiry_date"
		case status = "status"
		case created_by_id = "created_by_id"
		case created_datetime = "created_datetime"
		case image_path = "image_path"
		case publish_status = "publish_status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		origin = try values.decodeIfPresent(String.self, forKey: .origin)
		module = try values.decodeIfPresent(String.self, forKey: .module)
		promo_code = try values.decodeIfPresent(String.self, forKey: .promo_code)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		amt_min = try values.decodeIfPresent(String.self, forKey: .amt_min)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		value_type = try values.decodeIfPresent(String.self, forKey: .value_type)
		use_type = try values.decodeIfPresent(String.self, forKey: .use_type)
		limitation = try values.decodeIfPresent(String.self, forKey: .limitation)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
		created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
		image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
		publish_status = try values.decodeIfPresent(String.self, forKey: .publish_status)
	}

}