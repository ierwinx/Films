import RxSwift
import Foundation

class DetailViewModel {

    private weak var view: DetailView?
    private var router: DetailRouter?

    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    func getMovieData(iMoviewID: Int) -> Observable<DetailModel> {
        let getPelis = MoviesMannager()
        return getPelis.getMovie(iMovieID: iMoviewID)
    }

}
