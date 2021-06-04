class PhotosInteractor {
    private let photosRepository = PhotosRepository()
    private let albumModel: AlbumEntityModel
    
    init(albumModel: AlbumEntityModel) {
        self.albumModel = albumModel
    }
}

extension PhotosInteractor: PhotosInteracting {
    func getPhotosForAlbum(completion : @escaping([PhotoEntityModel]?,Error?) -> ()) {
        guard let albumId = albumModel.id else {return}
        photosRepository.getPhotosForAlbum(albumId: albumId, completion: completion)
    }
    
    func getAlbumTitle() -> String {
        guard let albumTitle = albumModel.title else {return ""}
        return albumTitle
    }
}
