import UIKit

class DetailView: UIViewController {

    private var router = DetailRouter()
    private var viewModel = DetailViewModel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "DetailView", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: self.router)
    }

}
