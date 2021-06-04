class UserDetailsBuilder {
    func buildUserDetailsModule() -> ComponentView {
        let viewController = UserDetailController()
        let interactor = UserDetailInteractor()
        let presenter = UserDetailPresenter(view: viewController, interactor: interactor)
        viewController.presenter = presenter
        return ComponentView(view: viewController)
    }
}
