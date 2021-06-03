protocol AlbumsInteracting {
    var albumsDataModel: AlbumsDataModel {get}
    func getAlbums(completion : @escaping([AlbumEntityModel]?,Error?) -> ())
}
