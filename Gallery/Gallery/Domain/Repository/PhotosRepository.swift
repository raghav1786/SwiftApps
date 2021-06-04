class PhotosRepository {
    let photosServices = PhotosServices()
    func getPhotosForAlbum(albumId: Int, completion : @escaping([PhotoEntityModel]?,Error?) -> ()) {
        let photosUrl = Constants.photosUrl+"\(albumId)/photos"
        photosServices.getPhotosForAlbum(urlString: photosUrl, completion: completion)
    }
}
