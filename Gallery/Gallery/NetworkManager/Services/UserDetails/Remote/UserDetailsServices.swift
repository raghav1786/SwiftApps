import Foundation
protocol UserDetailsServicesProtocol {
    func getUserDetails(urlString: String,
                        completion : @escaping(UserEntityModel?,Error?)
                            -> ())
}

class UserDetailsServices {
}
extension UserDetailsServices: UserDetailsServicesProtocol {
    
    func getUserDetails(urlString: String,
                        completion : @escaping(UserEntityModel?,Error?)
                            -> ()) {
        NetworkManager.shared.fetchDataForApi(urlString) { data, error in
            if let error = error {
                completion(nil,error)
            }
            if let result = data as? Data{
                completion(self.parseUserDetails(result),nil)
            }
        }
    }
    
    private func parseUserDetails(_ data: Data) -> UserEntityModel? {
        let decoder = JSONDecoder()
        do {
            let albums = try decoder.decode(UserEntityModel.self, from: data)
            return albums
        } catch {
            print("Unable to parse json :\(error)")
            return nil
        }
    }
}
