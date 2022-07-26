import Foundation
import RxSwift
import UIKit

class MoviesMannager {

    func getPopularMovies() -> Observable<MoviesModel> {

        return Observable.create { observer in

            let strUrl = Constants.URL.main + Constants.Endpoints.popularMovies + "?" + Constants.apiKey
            let session = URLSession.shared
            let endpoint: URL = URL(string: strUrl)!
            var request = URLRequest(url: endpoint)
            request.httpMethod = "GET"
            session.dataTask(with: request) { data, response, error in

                guard let serverCode = response as? HTTPURLResponse, error == nil else {
                    observer.onError(error ?? NSError(domain: "MoviesMannager.getPopularMovies.error", code: 401))
                    return
                }

                if serverCode.statusCode == 200 {
                    guard let dataRes = data,
                          let dataObj = try? JSONDecoder().decode(MoviesModel.self, from: dataRes) else {
                        observer.onError(NSError(domain: "MoviesMannager.getPopularMovies.parseObj", code: 500))
                        return
                    }

                    observer.onNext(dataObj)
                } else {
                    observer.onError(error ?? NSError(domain: "MoviesMannager.getPopularMovies.error", code: 401))
                }

                observer.onCompleted()
            }.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }

        }
    }

    func getMovie(iMovieID: Int) -> Observable<DetailModel> {

        return Observable.create { observer in
            let strUrl = Constants.URL.main + Constants.Endpoints.detalMovie + "/\(iMovieID)" + "?" + Constants.apiKey
            let session = URLSession.shared
            let endpoint: URL = URL(string: strUrl)!
            var request = URLRequest(url: endpoint)
            request.httpMethod = "GET"
            session.dataTask(with: request) { data, response, error in

                guard let serverCode = response as? HTTPURLResponse, error == nil else {
                    observer.onError(error ?? NSError(domain: "MoviesMannager.getMovie.error", code: 401))
                    return
                }

                if serverCode.statusCode == 200 {
                    guard let dataRes = data,
                          let dataObj = try? JSONDecoder().decode(DetailModel.self, from: dataRes) else {
                        observer.onError(NSError(domain: "MoviesMannager.getMovie.parseObj", code: 500))
                        return
                    }

                    observer.onNext(dataObj)
                } else {
                    observer.onError(error ?? NSError(domain: "MoviesMannager.getMovie.error", code: 401))
                }

                observer.onCompleted()
            }.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }

    func getMoviePoster(strPathPoster: String) -> Observable<UIImage> {

        return Observable.create { observer in
            let strUrl = Constants.URL.imagenes + strPathPoster
            let session = URLSession.shared
            let endpoint: URL = URL(string: strUrl)!
            var request = URLRequest(url: endpoint)
            request.httpMethod = "GET"
            session.dataTask(with: request) { data, response, error in
                guard let serverCode = response as? HTTPURLResponse, error == nil else {
                    observer.onError(error ?? NSError(domain: "MoviesMannager.getMoviePoster.error", code: 401))
                    return
                }
                if serverCode.statusCode == 200 {
                    guard let dataRes = data,
                        let imagen = UIImage(data: dataRes) else {
                        observer.onError(NSError(domain: "MoviesMannager.getMoviePoster.parseObj", code: 500))
                        return
                    }
                    observer.onNext(imagen)
                    observer.onCompleted()
                } else {
                    observer.onError(error ?? NSError(domain: "MoviesMannager.getMoviePoster.error", code: 401))
                }

            }.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }

        }

    }

}
