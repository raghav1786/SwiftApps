class AlbumsInteractor {
    private let albumsRepository = AlbumsRepository()
    
    let albumsDataModel: AlbumsDataModel
    
    init(albumsDataModel: AlbumsDataModel) {
        self.albumsDataModel = albumsDataModel
    }
}

extension AlbumsInteractor: AlbumsInteracting {
    func getAlbums(completion : @escaping([AlbumEntityModel]?,Error?) -> ()) {
        albumsRepository.getAlbums(completion: completion)
    }
}
