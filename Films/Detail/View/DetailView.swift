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

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DetailView", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

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
        lblTitle.text = self.pelicula?.title
        lblSinopsis.text = self.pelicula?.overview
        lblDate.text = "Fecha: \(self.pelicula?.releaseDate ?? "")"
        let strUrl = Constants.URL.imagenes + (self.pelicula?.posterPath ?? "")
        if let url = URL(string: strUrl), let data = try? Data(contentsOf: url) {
            imgPoster.image = UIImage(data: data)
        } else {
            imgPoster.image = UIImage(named: "claqueta")
        }
    }

}
