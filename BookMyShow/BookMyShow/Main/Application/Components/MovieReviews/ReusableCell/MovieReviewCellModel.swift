
import Foundation
class MovieReviewCellModel: NSObject {
    
    private var movieReviewModel:MovieReview?
    
    init(movieReviewModel:MovieReview) {
        super.init()
        self.movieReviewModel = movieReviewModel
    }
    
    var author: String {
        movieReviewModel?.author ?? ""
    }
    
    var authorIcon: String {
        var icon = movieReviewModel?.author_details?.avatar_path ?? "empty_image"
        icon.removeFirst()
        return icon
    }
    
    var createdDate:String{
        guard let date = movieReviewModel?.created_at,let lastIndex = date.lastIndex(of: "T") else { return ""}
        return String(date.prefix(upTo: lastIndex))
    }
    
    var content: String {
        return movieReviewModel?.content ?? ""
    }
    
    var rating: String {
        guard let content = movieReviewModel?.content else { return ""}
        if let lastIndex = content.lastIndex(of: "R") {
            return String(content.suffix(from: lastIndex))
        }
        return ""
    }
}
