import UIKit
import Foundation

extension HomeView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peliculas?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celda = tableView.dequeueReusableCell(withIdentifier: "CeldaMovies", for: indexPath)
                as? PeliculaTableViewCell else { return UITableViewCell() }
        let peli = self.peliculas?.results[indexPath.row]
        let strTitulo = peli?.originalTitle ?? ""
        let strDescripcion = peli?.overview ?? ""
        let strUrlImage = peli?.posterPath ?? ""
        celda.setData(strTitle: strTitulo, strDescr: strDescripcion, strImage: strUrlImage)
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }

}
