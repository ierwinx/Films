import Foundation
import UIKit

class HomeRouter {

    private var sourceView: UIViewController?

    public class func createViewController() -> UIViewController {
        let view = HomeView()
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }

}
