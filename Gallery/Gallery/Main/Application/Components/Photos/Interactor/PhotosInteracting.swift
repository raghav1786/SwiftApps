protocol PhotosInteracting {
    func getPhotosForAlbum(completion : @escaping([PhotoEntityModel]?,Error?) -> ())
    func getAlbumTitle() -> String
}
