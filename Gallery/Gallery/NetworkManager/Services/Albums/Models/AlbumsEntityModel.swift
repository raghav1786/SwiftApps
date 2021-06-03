import Foundation
struct AlbumsEntityModel: Decodable {
    var albums: [AlbumEntityModel]
}

struct AlbumEntityModel: Decodable {
    var userId: Int?
    var id: Int?
    var title: String?
}
