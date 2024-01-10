
import Foundation
struct Pre_booking_cancellation_policy : Codable {
	let amount : String?
	let from_time : String?
	let currency : String?
	let from : String?

	enum CodingKeys: String, CodingKey {

		case amount = "amount"
		case from_time = "from_time"
		case currency = "currency"
		case from = "from"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(String.self, forKey: .amount)
		from_time = try values.decodeIfPresent(String.self, forKey: .from_time)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		from = try values.decodeIfPresent(String.self, forKey: .from)
	}

}
