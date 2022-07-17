import UIKit
import Foundation

extension HomeView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CeldaMovies", for: indexPath)
        celda.textLabel?.text = "Pelicula \(indexPath.row)"
        celda.detailTextLabel?.text = "Detalle...."
        return celda
    }

}
