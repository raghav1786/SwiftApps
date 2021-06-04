import CoreLocation
protocol HomePresentable {
    var isAlbumsVisible: Bool {get set}
    var isUserDetailsVisible: Bool{get set}
    func onViewDidLoad()
    func getAlbumsForUser()
    func getUserDetails()
}
