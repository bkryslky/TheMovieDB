//
//  DetailContracts.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import Foundation
protocol DetailViewToPresenter {
    var view:DetailPresenterToView? {get set}
    var interactor:DetailPresenterToInteractor? {get set}
    var router:DetailPresenterToWireframe? {get set}
    
    func startGettingDetails(movieId:Int) 
}

protocol DetailPresenterToInteractor {
    var presenter:DetailInteractorToPresenter? {get set}
    func getMovieDetail(movieId:Int)
    func getSimilarMovies(movieId:Int)
}

protocol DetailInteractorToPresenter {
    func didGetMovieDetail(detail:MovieDetail)
    func didGetSimilarMovies(movies:[Movie])
    func didGetError(error:APIError)
    
}

protocol DetailPresenterToWireframe:BaseWireframe{
    func goToDetail(from view:DetailPresenterToView,movie:Movie)
}

protocol DetailPresenterToView {
    func displaySimilarMovies(movies:[Movie])
    func displayMovieDetail(detail:MovieDetail)
    func displayError(error:APIError)
    func displayLoading(status:Bool)
}
