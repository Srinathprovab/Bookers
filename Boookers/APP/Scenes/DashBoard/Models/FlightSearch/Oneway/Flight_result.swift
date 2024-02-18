

import Foundation
struct Flight_result : Codable {
	let flight_details : Flight_details?
	//let fare : [Fare]?
	let price : Price?
	let access_key : String?
    let faretype : Bool?
    let booking_source : String?
    
	enum CodingKeys: String, CodingKey {

		case flight_details = "flight_details"
	//	case fare = "fare"
		case price = "price"
		case access_key = "access_key"
        case faretype = "faretype"
        case booking_source = "booking_source"
        
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
		//fare = try values.decodeIfPresent([Fare].self, forKey: .fare)
		price = try values.decodeIfPresent(Price.self, forKey: .price)
		access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        faretype = try values.decodeIfPresent(Bool.self, forKey: .faretype)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
	}

}
