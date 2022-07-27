import UIKit
import RxSwift
import RxCocoa

class DetailView: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var imgPoster: UIImageView!
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var lblSinopsis: UILabel!

    // MARK: - Variables
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    public var iMovieID: Int?
    private var pelicula: DetailModel?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: self.router)
        getData()
    }

    // MARK: - Private methods
    private func getData() {
        viewModel.getMovieData(iMoviewID: iMovieID ?? 0)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { pelicula in
                self.pelicula = pelicula
                self.fillData()
            } onError: { error in
                debugPrint(error)
            } onCompleted: {
                debugPrint("Exito al completar")
            }.disposed(by: disposeBag)
    }

    private func fillData() {
        DispatchQueue.main.async {
            self.lblTitle.text = self.pelicula?.title
            self.lblSinopsis.text = self.pelicula?.overview
            self.lblDate.text = "Fecha: \(self.pelicula?.releaseDate ?? "")"
            self.getPoster(strPoster: self.pelicula?.posterPath ?? "")
        }
    }

    private func getPoster(strPoster: String) {
        viewModel.getImageMovie(strPathImage: strPoster)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { imagen in
                self.fillImage(imgPoster: imagen)
            } onError: { error in
                debugPrint(error)
                self.fillImage(imgPoster: nil)
            } onCompleted: {
                debugPrint("Exito al completar")
            }.disposed(by: disposeBag)
    }

    private func fillImage(imgPoster: UIImage?) {
        DispatchQueue.main.async {
            self.imgPoster.image = imgPoster != nil ? imgPoster : UIImage(named: "claqueta")
        }
    }

}
