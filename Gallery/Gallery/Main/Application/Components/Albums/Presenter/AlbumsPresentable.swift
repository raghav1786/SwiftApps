protocol AlbumsPresentable {
    var albums: [AlbumEntityModel] {get set}
    func onViewDidLoad()
    func getPhotoForAlbum(albumModel: AlbumEntityModel)
}
