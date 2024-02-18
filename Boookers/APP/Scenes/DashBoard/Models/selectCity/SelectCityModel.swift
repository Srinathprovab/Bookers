




import Foundation
struct SelectCityModel : Codable {
    let label : String?
    let value : String?
    let id : String?
    let code : String?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case value = "value"
        case id = "id"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }

}
