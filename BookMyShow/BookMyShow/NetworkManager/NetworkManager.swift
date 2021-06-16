import Foundation
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchDataForApi(_ urlString: String, completion : @escaping(Any?,Error?) -> ()) {
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlString) else { return completion(nil,nil) }
        let task = session.dataTask(with: url) { (data,response,error) in
            if let error = error {
                completion(nil,error)
            }
            if let safeData = data {
                completion(safeData, nil)
            }
        }
        task.resume()
    }
}
