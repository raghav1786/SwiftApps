class PhotosDetailInteractor {
    let photoModel: PhotoEntityModel
    
    init(photoModel: PhotoEntityModel) {
        self.photoModel = photoModel
    }
}

extension PhotosDetailInteractor: PhotosDetailInteracting {
    func getPhotoModel() -> PhotoEntityModel {
        return photoModel
    }
}
