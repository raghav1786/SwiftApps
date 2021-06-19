
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
        if let firstChar = icon.first,firstChar == "h" {
            return icon
        } else {
            return MovieReviewConstants.secureImageURL + icon
        }
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
        if let lastChar = content.last,lastChar == "*", let firstIndex = content.firstIndex(of: lastChar)  {
            return MovieReviewConstants.ratings + String(content.suffix(from: firstIndex))
        }
        if let lastIndex = content.lastIndex(of: ":") {
            return MovieReviewConstants.ratings + String(content.suffix(from: lastIndex))
        }
        return ""
    }
}
