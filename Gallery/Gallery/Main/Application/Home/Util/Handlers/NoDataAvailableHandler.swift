public class NoData {
    public enum NoDataUseCase {
        case photos
        case albums
    }
    
    static let photosErrorMessage = "We are unable to get the photos at the moment.\nPlease retry after sometime"
    static let albumsErrorMessage = "We are unable to get the albums at the moment.\nPlease retry after sometime"
    
    public func getNoCityDataModel(type: NoDataUseCase) -> NoDataUIModel {
        switch type {
        case .photos:
            return NoDataUIModel(titleMessage: NoData.photosErrorMessage)
        case .albums:
            return NoDataUIModel(titleMessage: NoData.albumsErrorMessage)
        }
    }
}


public struct NoDataUIModel {
    let titleMessage: String
}
