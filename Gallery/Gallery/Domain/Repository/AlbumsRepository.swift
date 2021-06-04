class AlbumsRepository {
    let albumsServices = AlbumsServices()
    func getAlbums(completion : @escaping([AlbumEntityModel]?,Error?) -> ()) {
        let albumsUrl = Constants.userDetailsUrl+"/albums"
        albumsServices.getAlbums(urlString: albumsUrl,completion: completion)
    }
}
