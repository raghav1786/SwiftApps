protocol PhotosPresentable {
    var photosModel: [PhotoEntityModel] {get set}
    func onViewDidLoad()
    func openPhotosDetails(photoModel: PhotoEntityModel)
    func getAlbumTitle() -> String
}
