

import Foundation
struct Booking_data : Codable {
	let booking_details : [Booking_details]?
	let booking_itinerary_details : [Booking_itinerary_details]?
	let booking_transaction_details : [Booking_transaction_details]?
	let booking_customer_details : [Booking_customer_details]?
	let cancellation_details : String?

	enum CodingKeys: String, CodingKey {

		case booking_details = "booking_details"
		case booking_itinerary_details = "booking_itinerary_details"
		case booking_transaction_details = "booking_transaction_details"
		case booking_customer_details = "booking_customer_details"
		case cancellation_details = "cancellation_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
		booking_itinerary_details = try values.decodeIfPresent([Booking_itinerary_details].self, forKey: .booking_itinerary_details)
		booking_transaction_details = try values.decodeIfPresent([Booking_transaction_details].self, forKey: .booking_transaction_details)
		booking_customer_details = try values.decodeIfPresent([Booking_customer_details].self, forKey: .booking_customer_details)
		cancellation_details = try values.decodeIfPresent(String.self, forKey: .cancellation_details)
	}

}
