//
//  DetailPresenter.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import Foundation

class DetailPresenter:DetailViewToPresenter{
    
    var view: DetailPresenterToView?
    
    var interactor: DetailPresenterToInteractor?
    
    var router: DetailPresenterToWireframe?
    
    func startGettingDetails(movieId:Int) {
        view?.displayLoading(status: true)
        interactor?.getMovieDetail(movieId: movieId)
        interactor?.getSimilarMovies(movieId: movieId)
    }
    
}
extension DetailPresenter:DetailInteractorToPresenter{
    func didGetMovieDetail(detail: MovieDetail) {
        view?.displayMovieDetail(detail: detail)
    }
    
    func didGetSimilarMovies(movies: [Movie]) {
        view?.displaySimilarMovies(movies:movies)
        view?.displayLoading(status: false)
    }
    func didGetError(error: APIError) {
        view?.displayError(error: error)
    }
    
}

