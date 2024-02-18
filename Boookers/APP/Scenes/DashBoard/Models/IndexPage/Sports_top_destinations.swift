

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
