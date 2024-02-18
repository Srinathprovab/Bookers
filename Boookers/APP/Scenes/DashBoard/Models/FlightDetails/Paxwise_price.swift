/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Paxwise_price : Codable {
	let adult_pax_count : Int?
	let adult_base_fare : Double?
	let adult_tax_fare : Double?
	let child_pax_count : Int?
	let child_base_fare : Double?
	let child_tax_fare : Double?
	let infant_pax_count : Int?
	let infant_base_fare : Double?
	let infant_tax_fare : Double?

	enum CodingKeys: String, CodingKey {

		case adult_pax_count = "adult_pax_count"
		case adult_base_fare = "adult_base_fare"
		case adult_tax_fare = "adult_tax_fare"
		case child_pax_count = "child_pax_count"
		case child_base_fare = "child_base_fare"
		case child_tax_fare = "child_tax_fare"
		case infant_pax_count = "infant_pax_count"
		case infant_base_fare = "infant_base_fare"
		case infant_tax_fare = "infant_tax_fare"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		adult_pax_count = try values.decodeIfPresent(Int.self, forKey: .adult_pax_count)
		adult_base_fare = try values.decodeIfPresent(Double.self, forKey: .adult_base_fare)
		adult_tax_fare = try values.decodeIfPresent(Double.self, forKey: .adult_tax_fare)
		child_pax_count = try values.decodeIfPresent(Int.self, forKey: .child_pax_count)
		child_base_fare = try values.decodeIfPresent(Double.self, forKey: .child_base_fare)
		child_tax_fare = try values.decodeIfPresent(Double.self, forKey: .child_tax_fare)
		infant_pax_count = try values.decodeIfPresent(Int.self, forKey: .infant_pax_count)
		infant_base_fare = try values.decodeIfPresent(Double.self, forKey: .infant_base_fare)
		infant_tax_fare = try values.decodeIfPresent(Double.self, forKey: .infant_tax_fare)
	}

}