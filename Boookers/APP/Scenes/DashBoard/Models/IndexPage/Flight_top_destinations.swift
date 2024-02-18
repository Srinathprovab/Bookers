

import Foundation
struct Flight_top_destinations : Codable {
    let id : String?
    let title : String?
    let from_city : String?
    let to_city : String?
    let travel_date : String?
    let return_date : String?
    let image : String?
    let status : String?
    let airline_id : String?
    let airline_class : String?
    let trip_type : String?
    let price : String?
    let created_at : String?
    let updated_at : String?
    let from_airport_name : String?
    let to_airport_name : String?
    let from_city_name : String?
    let airport_code : String?
    let from_city_loc : String?
    let from_country : String?
    let to_city_name : String?
    let to_country : String?
    let to_city_loc : String?
    let widget_title : String?
    let airport_name : String?
    let hit_url : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case from_city = "from_city"
        case to_city = "to_city"
        case travel_date = "travel_date"
        case return_date = "return_date"
        case image = "image"
        case status = "status"
        case airline_id = "airline_id"
        case airline_class = "airline_class"
        case trip_type = "trip_type"
        case price = "price"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case from_airport_name = "from_airport_name"
        case to_airport_name = "to_airport_name"
        case from_city_name = "from_city_name"
        case airport_code = "airport_code"
        case from_city_loc = "from_city_loc"
        case from_country = "from_country"
        case to_city_name = "to_city_name"
        case to_country = "to_country"
        case to_city_loc = "to_city_loc"
        case widget_title = "widget_title"
        case airport_name = "airport_name"
        case hit_url = "hit_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        from_city = try values.decodeIfPresent(String.self, forKey: .from_city)
        to_city = try values.decodeIfPresent(String.self, forKey: .to_city)
        travel_date = try values.decodeIfPresent(String.self, forKey: .travel_date)
        return_date = try values.decodeIfPresent(String.self, forKey: .return_date)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        airline_id = try values.decodeIfPresent(String.self, forKey: .airline_id)
        airline_class = try values.decodeIfPresent(String.self, forKey: .airline_class)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        from_airport_name = try values.decodeIfPresent(String.self, forKey: .from_airport_name)
        to_airport_name = try values.decodeIfPresent(String.self, forKey: .to_airport_name)
        from_city_name = try values.decodeIfPresent(String.self, forKey: .from_city_name)
        airport_code = try values.decodeIfPresent(String.self, forKey: .airport_code)
        from_city_loc = try values.decodeIfPresent(String.self, forKey: .from_city_loc)
        from_country = try values.decodeIfPresent(String.self, forKey: .from_country)
        to_city_name = try values.decodeIfPresent(String.self, forKey: .to_city_name)
        to_country = try values.decodeIfPresent(String.self, forKey: .to_country)
        to_city_loc = try values.decodeIfPresent(String.self, forKey: .to_city_loc)
        widget_title = try values.decodeIfPresent(String.self, forKey: .widget_title)
        airport_name = try values.decodeIfPresent(String.self, forKey: .airport_name)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
    }

}
