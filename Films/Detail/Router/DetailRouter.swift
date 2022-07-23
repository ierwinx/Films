import UIKit
import Foundation

class DetailRouter {

    private var sourceView: UIViewController?

    class func createViewController(iMovieID: Int) -> UIViewController {
        let view = DetailView()
        view.iMovieID = iMovieID
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }

}
