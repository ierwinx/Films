import UIKit
import Foundation

extension HomeView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 139
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredMovies?.count ?? 0
        } else {
            return self.peliculas?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celda = tableView.dequeueReusableCell(withIdentifier: "CeldaMovies", for: indexPath)
                as? PeliculaTableViewCell else { return UITableViewCell() }
        let peli = searchController.isActive && searchController.searchBar.text != "" ?
            self.filteredMovies?[indexPath.row] : self.peliculas?[indexPath.row]
        let strTitulo = peli?.originalTitle ?? ""
        let strDescripcion = peli?.overview ?? ""
        let strUrlImage = peli?.posterPath ?? ""
        celda.setData(strTitle: strTitulo, strDescr: strDescripcion, strImage: strUrlImage)
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peli = searchController.isActive && searchController.searchBar.text != "" ?
            self.filteredMovies?[indexPath.row] : self.peliculas?[indexPath.row]
        router.openDetail(iMovieID: peli?.id ?? 0)
    }

}

extension HomeView: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTable()
    }

}
