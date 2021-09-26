import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchDataForApi(_ urlString: String) -> Future<Any?,Error> {
        Future { promise in
            let session = URLSession(configuration: .default)
            guard let url = URL(string: urlString) else {
                promise(.failure(NetworkError.invlaidURL))
                return
            }
            let task = session.dataTask(with: url) { (data,response,error) in
                if let error = error {
                    promise(.failure(error))
                }
                if let safeData = data {
                    promise(.success(safeData))
                }
            }
            task.resume()
        }
    }
}
