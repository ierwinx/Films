import UIKit

class HomeView: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var spinLoader: UIActivityIndicatorView!

    // MARK: - Variables
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()

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
        tblMovies.register(UITableViewCell.self, forCellReuseIdentifier: "CeldaMovies")
        spinLoader.isHidden = true
    }

}
