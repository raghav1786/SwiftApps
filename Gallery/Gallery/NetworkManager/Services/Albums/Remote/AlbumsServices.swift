import Foundation
protocol AlbumsServicesProtocol {
    func getAlbums(urlString: String,
                   completion : @escaping([AlbumEntityModel]?,Error?)
                    -> ())
}

class AlbumsServices {
}
extension AlbumsServices: AlbumsServicesProtocol {
    
    func getAlbums(urlString: String,
                   completion : @escaping([AlbumEntityModel]?,Error?)
                    -> ()) {
        NetworkManager.shared.fetchDataForApi(urlString) { data, error in
            if let error = error {
                completion(nil,error)
            }
            if let result = data as? Data{
                completion(self.parseAlbumsData(result),nil)
            }
        }
    }
    
    private func parseAlbumsData(_ data: Data) -> [AlbumEntityModel]? {
        let decoder = JSONDecoder()
        do {
            let albums = try decoder.decode([AlbumEntityModel].self, from: data)
            return albums
        } catch {
            print("Unable to parse json :\(error)")
            return nil
        }
    }
}
