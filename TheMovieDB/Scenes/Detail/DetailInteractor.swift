//
//  DetailInteractor.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import Foundation

class DetailInteractor:DetailPresenterToInteractor{
    var presenter: DetailInteractorToPresenter?
    private let endpoint:Endpoint

    
    init(endpoint:Endpoint) {
        self.endpoint = endpoint
    }
    
    func getMovieDetail(movieId: Int) {
        endpoint.getMovieDetail(movie: movieId) { result in
            switch result{
            case .success(let detail):
                self.presenter?.didGetMovieDetail(detail:detail)
                break
            case .failure(let error):
                self.presenter?.didGetError(error: error)
                break
            }
        }
    }
    
    func getSimilarMovies(movieId: Int) {
        endpoint.getSimilarMovies(movie: movieId) { result in
            switch result{
            case .success(let base):
                if let movies = base.data{
                    self.presenter?.didGetSimilarMovies(movies:movies)
                }
                break
            case .failure(let error):
                self.presenter?.didGetError(error: error)
                break
            }
        }
    }
    
    
}
