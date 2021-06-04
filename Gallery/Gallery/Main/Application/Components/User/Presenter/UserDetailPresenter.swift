import Foundation
class UserDetailPresenter {
    private var interactor: UserDetailInteracting?
    private weak var view: UserDetailViewable?
    init(view: UserDetailViewable,interactor: UserDetailInteracting) {
        self.view = view
        self.interactor = interactor
    }
}

extension UserDetailPresenter: UserDetailPresentable {
    func onViewDidLoad() {
        getUserDetails()
    }
    private func getUserDetails() {
        _ = self.interactor?.getUserDetails(completion: { (result, error) in
            DispatchQueue.main.async {
                ActivityIndicator.shared.stopAnimation()
                ActivityIndicator.shared.removeActivityIndicator()
                if let result = result {
                    self.view?.setData(userEntityModel: result)
                }
                
            }
        })
    }}
