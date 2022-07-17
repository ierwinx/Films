import Foundation
import UIKit

class HomeRouter {

    var viewController: UIViewController {
        return self.createViewController()
    }

    private var sourceView: UIViewController?

    private func createViewController() -> UIViewController {
        let view = HomeView()
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }

}
