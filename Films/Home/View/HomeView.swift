import UIKit
import RxSwift

class HomeView: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var spinLoader: UIActivityIndicatorView!

    // MARK: - Variables
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    public var peliculas: MoviesModel?

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HomeView", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: self.router)

        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.register(UINib(nibName: "PeliculaTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: "CeldaMovies")
        spinLoader.isHidden = false
        spinLoader.startAnimating()

        getData()
    }

    private func getData() {
        return viewModel.getListPupularMovies()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { peliculas in
                self.peliculas = peliculas
            } onError: { error in
                debugPrint(error)
                self.reloadTable()
            } onCompleted: {
                self.reloadTable()
            }.disposed(by: disposeBag)
    }

    private func reloadTable() {
        DispatchQueue.main.async {
            self.spinLoader.stopAnimating()
            self.spinLoader.isHidden = true
            self.tblMovies.reloadData()
        }
    }

}
