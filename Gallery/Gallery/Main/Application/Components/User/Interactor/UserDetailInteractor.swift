class UserDetailInteractor {
    private let userDetailsRepository = UserDetailsRepository()
}

extension UserDetailInteractor: UserDetailInteracting {
    func getUserDetails(completion : @escaping(UserEntityModel?,Error?) -> ()) {
        userDetailsRepository.getUserDetails(completion: completion)
    }
}
