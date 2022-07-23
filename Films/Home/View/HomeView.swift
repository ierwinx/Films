import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var spinLoader: UIActivityIndicatorView!

    // MARK: - Variables
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    public var peliculas: [Movie]?
    public var filteredMovies: [Movie]?
    public var strIDMovie: String = "0"

    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = true
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .default
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Busca una pelicula"
        return controller
    })()

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

        navigationItem.title = "Peliculas"

        manageSarchBarControl()

        getData()
    }

    // MARK: - Private methods
    private func getData() {
        viewModel.getListPupularMovies()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { peliculas in
                self.peliculas = peliculas.results
            } onError: { error in
                debugPrint(error)
                self.reloadTable()
            } onCompleted: {
                self.reloadTable()
            }.disposed(by: disposeBag)
    }

    public func reloadTable() {
        DispatchQueue.main.async {
            self.spinLoader.stopAnimating()
            self.spinLoader.isHidden = true
            self.tblMovies.reloadData()
        }
    }

    private func manageSarchBarControl() {
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        tblMovies.tableHeaderView = searchBar
        tblMovies.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { result in
                self.filteredMovies = self.peliculas?.filter({ movie in
                    self.reloadTable()
                    return movie.title.contains(result)
                })
            }).disposed(by: disposeBag)
    }

}
