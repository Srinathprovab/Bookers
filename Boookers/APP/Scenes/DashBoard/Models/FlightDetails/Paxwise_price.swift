

import Foundation
struct Paxwise_price : Codable {
    let adult_pax_count : Int?
    let adult_base_fare : Double?
    let adult_tax_fare : Double?
    let adult_sub_fare : Double?
    let adult_total_fare : Double?
    let child_pax_count : Int?
    let child_base_fare : Double?
    let child_tax_fare : Double?
    let child_sub_fare : Double?
    let child_total_fare : Double?
    let infant_pax_count : Int?
    let infant_base_fare : Double?
    let infant_tax_fare : Double?
    let infant_sub_fare : Double?
    let infant_total_fare : Double?

    enum CodingKeys: String, CodingKey {

        case adult_pax_count = "adult_pax_count"
        case adult_base_fare = "adult_base_fare"
        case adult_tax_fare = "adult_tax_fare"
        case adult_sub_fare = "adult_sub_fare"
        case adult_total_fare = "adult_total_fare"
        case child_pax_count = "child_pax_count"
        case child_base_fare = "child_base_fare"
        case child_tax_fare = "child_tax_fare"
        case child_sub_fare = "child_sub_fare"
        case child_total_fare = "child_total_fare"
        case infant_pax_count = "infant_pax_count"
        case infant_base_fare = "infant_base_fare"
        case infant_tax_fare = "infant_tax_fare"
        case infant_sub_fare = "infant_sub_fare"
        case infant_total_fare = "infant_total_fare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult_pax_count = try values.decodeIfPresent(Int.self, forKey: .adult_pax_count)
        adult_base_fare = try values.decodeIfPresent(Double.self, forKey: .adult_base_fare)
        adult_tax_fare = try values.decodeIfPresent(Double.self, forKey: .adult_tax_fare)
        adult_sub_fare = try values.decodeIfPresent(Double.self, forKey: .adult_sub_fare)
        adult_total_fare = try values.decodeIfPresent(Double.self, forKey: .adult_total_fare)
        child_pax_count = try values.decodeIfPresent(Int.self, forKey: .child_pax_count)
        child_base_fare = try values.decodeIfPresent(Double.self, forKey: .child_base_fare)
        child_tax_fare = try values.decodeIfPresent(Double.self, forKey: .child_tax_fare)
        child_sub_fare = try values.decodeIfPresent(Double.self, forKey: .child_sub_fare)
        child_total_fare = try values.decodeIfPresent(Double.self, forKey: .child_total_fare)
        infant_pax_count = try values.decodeIfPresent(Int.self, forKey: .infant_pax_count)
        infant_base_fare = try values.decodeIfPresent(Double.self, forKey: .infant_base_fare)
        infant_tax_fare = try values.decodeIfPresent(Double.self, forKey: .infant_tax_fare)
        infant_sub_fare = try values.decodeIfPresent(Double.self, forKey: .infant_sub_fare)
        infant_total_fare = try values.decodeIfPresent(Double.self, forKey: .infant_total_fare)
    }

}
