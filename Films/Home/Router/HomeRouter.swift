import Foundation
import UIKit

class HomeRouter {

    private var sourceView: UIViewController?

    public class func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }

    func openDetail(iMovieID: Int) {
        let newController = DetailRouter.createViewController(iMovieID: iMovieID)
        sourceView?.navigationController?.pushViewController(newController, animated: true)
    }

}
