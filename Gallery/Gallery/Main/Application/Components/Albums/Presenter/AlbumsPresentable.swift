protocol AlbumsPresentable {
    var albums: [AlbumEntityModel] {get set}
    func onViewDidLoad()
    func getPhotoForAlbum(albumID: Int)
}
