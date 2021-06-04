class AlbumsRepository {
    let albumsServices = AlbumsServices()
    func getPhotosForAlbum(albumId: Int, completion : @escaping([PhotoEntityModel]?,Error?) -> ()) {
        let photosUrl = Constants.photosUrl+"\(albumId)/photos"
        albumsServices.getPhotosForAlbum(urlString: photosUrl, completion: completion)
    }
    
    func getAlbums(completion : @escaping([AlbumEntityModel]?,Error?) -> ()) {
        let albumsUrl = Constants.userDetailsUrl+"/albums"
        albumsServices.getAlbums(urlString: albumsUrl,completion: completion)
    }
}
