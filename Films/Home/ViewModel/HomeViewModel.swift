import Foundation

class HomeViewModel {

    private weak var view: HomeView?
    private var router: HomeRouter?

    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

}
