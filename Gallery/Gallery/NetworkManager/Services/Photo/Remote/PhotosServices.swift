import Foundation
protocol PhotosServicesProtocol {
    func getPhotosForAlbum(urlString: String, completion : @escaping([PhotoEntityModel]?,Error?) -> ())
}

class PhotosServices {
}
extension PhotosServices: PhotosServicesProtocol {
    func getPhotosForAlbum(urlString: String, completion : @escaping([PhotoEntityModel]?,Error?)
                            -> ()) {
        NetworkManager.shared.fetchDataForApi(urlString) { data, error in
            if let error = error {
                completion(nil,error)
            }
            if let result = data as? Data{
                completion(self.parsePhotosData(result),nil)
            }
        }
    }
    
    private func parsePhotosData(_ data: Data) -> [PhotoEntityModel]? {
        let decoder = JSONDecoder()
        do {
            let photos = try decoder.decode([PhotoEntityModel].self, from: data)
            return photos
        } catch {
            print("Unable to parse json :\(error)")
            return nil
        }
    }
}
