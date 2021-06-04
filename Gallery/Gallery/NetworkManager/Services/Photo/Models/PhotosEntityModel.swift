struct PhotosEntityModel: Decodable {
    var photos: [PhotoEntityModel]
}


struct PhotoEntityModel: Decodable {
    var albumId: Int32?
    var id: Int32?
    var title: String?
    var urlString: String?
    var thumbnailUrlString: String?
    private enum CodingKeys : String, CodingKey {
            case urlString = "url", thumbnailUrlString = "thumbnailUrl",albumId,id,title
    }
}
