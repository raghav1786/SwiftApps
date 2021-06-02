import Foundation
struct AlbumsEntityModel: Decodable {
    var albums: [AlbumEntityModel]
}

struct AlbumEntityModel: Decodable {
    var userId: Int32?
    var id: Int32?
    var title: String?
}
