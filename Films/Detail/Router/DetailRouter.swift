import UIKit
import Foundation

class DetailRouter {

    var viewController: UIViewController {
        return self.createViewController()
    }

    private var sourceView: UIViewController?

    private func createViewController() -> UIViewController {
        let view = DetailView()
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }

}
