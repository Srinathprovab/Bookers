

import Foundation
struct Hotel_top_destination : Codable {
    let id : String?
    let title : String?
    let city : String?
    let check_in : String?
    let check_out : String?
    let image : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let city_name : String?
    let country_name : String?
    let hit_url : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case city = "city"
        case check_in = "check_in"
        case check_out = "check_out"
        case image = "image"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case city_name = "city_name"
        case country_name = "country_name"
        case hit_url = "hit_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
        check_out = try values.decodeIfPresent(String.self, forKey: .check_out)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        hit_url = try values.decodeIfPresent(String.self, forKey: .hit_url)
    }

}
