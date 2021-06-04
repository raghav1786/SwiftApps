class UserDetailsRepository {
    let userDetailsServices = UserDetailsServices()
    func getUserDetails(completion : @escaping(UserEntityModel?,Error?)
                            -> ()) {
        let userDetailsUrl = Constants.userDetailsUrl
        userDetailsServices.getUserDetails(urlString: userDetailsUrl, completion : completion)
    }
}
