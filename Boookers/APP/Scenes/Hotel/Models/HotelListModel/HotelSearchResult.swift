

import Foundation
struct HotelSearchResult : Codable {
    let booking_source : String?
    let location : String?
    let star_rating : Int?
    let facility_search : [String]?
    let extra_details : Extra_details?
    let country_code : String?
    let image : String?
    let accomodation_cstr : String?
    let facility_cstr : String?
    let city_code : String?
    let fax : String?
    let hotel_code : Int?
    let hotel_desc : String?
    let city_name : String?
    let latitude : String?
    let currency : String?
    let name : String?
    let xml_currency : String?
    let no_of_nights : Int?
    let facility : [HFacility]?
    let country_name : String?
    let phone_number : String?
    let email : String?
    let website : String?
    let longitude : String?
    let thumb_image : String?
    let xml_price : String?
    let refund : String?
    let xml_net : String?
    let price : String?
    let address : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case location = "location"
        case star_rating = "star_rating"
        case facility_search = "facility_search"
        case extra_details = "extra_details"
        case country_code = "country_code"
        case image = "image"
        case accomodation_cstr = "accomodation_cstr"
        case facility_cstr = "facility_cstr"
        case city_code = "city_code"
        case fax = "fax"
        case hotel_code = "hotel_code"
        case hotel_desc = "hotel_desc"
        case city_name = "city_name"
        case latitude = "latitude"
        case currency = "currency"
        case name = "name"
        case xml_currency = "xml_currency"
        case no_of_nights = "no_of_nights"
        case facility = "facility"
        case country_name = "country_name"
        case phone_number = "phone_number"
        case email = "email"
        case website = "website"
        case longitude = "longitude"
        case thumb_image = "thumb_image"
        case xml_price = "xml_price"
        case refund = "refund"
        case xml_net = "xml_net"
        case price = "price"
        case address = "address"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        facility_search = try values.decodeIfPresent([String].self, forKey: .facility_search)
        extra_details = try values.decodeIfPresent(Extra_details.self, forKey: .extra_details)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        accomodation_cstr = try values.decodeIfPresent(String.self, forKey: .accomodation_cstr)
        facility_cstr = try values.decodeIfPresent(String.self, forKey: .facility_cstr)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        fax = try values.decodeIfPresent(String.self, forKey: .fax)
        hotel_code = try values.decodeIfPresent(Int.self, forKey: .hotel_code)
        hotel_desc = try values.decodeIfPresent(String.self, forKey: .hotel_desc)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        xml_currency = try values.decodeIfPresent(String.self, forKey: .xml_currency)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        facility = try values.decodeIfPresent([HFacility].self, forKey: .facility)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        thumb_image = try values.decodeIfPresent(String.self, forKey: .thumb_image)
        xml_price = try values.decodeIfPresent(String.self, forKey: .xml_price)
        refund = try values.decodeIfPresent(String.self, forKey: .refund)
        xml_net = try values.decodeIfPresent(String.self, forKey: .xml_net)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        address = try values.decodeIfPresent(String.self, forKey: .address)
    }

}
