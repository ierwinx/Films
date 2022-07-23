import Foundation

struct DetailModel: Decodable {

    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }

}
