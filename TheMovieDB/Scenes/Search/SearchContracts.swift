//
//  SearchContracts.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import Foundation
protocol SearchViewToPresenter {
    var view:SearchPresenterToView? { get set }
    var interactor:SearchPresenterToInteractor? { get set }
    var router:SearchPresenterToWireFrame? { get set }
    func startSearchMovies(search text:String)
}
protocol SearchPresenterToInteractor {
    var presenter:SearchInteractorToPresenter? { get set }
    func searchMovies(search text:String)
}
protocol SearchInteractorToPresenter {
    func didSearchMovies(movies:[Movie])
}
protocol SearchPresenterToWireFrame:BaseWireframe{
    func goToDetail(from view:SearchPresenterToView, movie:Movie)
}
protocol SearchPresenterToView {
    func displayMovies(movies:[Movie])
}
