protocol UserDetailInteracting {
    func getUserDetails(completion : @escaping(UserEntityModel?,Error?) -> ())
}
