import Foundation
struct MovieCollectionViewCellModel {
    var movieImageUrlString: String?
    var movieTitle: String?
    var movieDesc: String?
    var releaseDate: String?
    var movieID : Int64?
}

class MovieListModel: NSObject {
    private var movieListModel:MovieCollectionViewCellModel?
    init(movieListModel:MovieCollectionViewCellModel) {
        super.init()
        self.movieListModel = movieListModel
    }
    
    var movieID: Int64 {
        return movieListModel?.movieID ?? 0
    }
    
    var movieTitle:String {
        return movieListModel?.movieTitle ?? "Untitled"
    }
    
    var movieDesc: String {
        return movieListModel?.movieDesc ?? ""
    }
    
    var releaseDate:String{
        return movieListModel?.releaseDate ?? "Updating Soon"
    }
    
    var movieImageUrlString: String {
        return movieListModel?.movieImageUrlString ?? ""
    }
}
