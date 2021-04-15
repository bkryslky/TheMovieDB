//
//  SearchPresenter.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 15.04.2021.
//

import Foundation

class SearchPresenter:SearchViewToPresenter{
    
    var view: SearchPresenterToView?
    
    var interactor: SearchPresenterToInteractor?
    
    var router: SearchPresenterToWireFrame?
    
    func startSearchMovies(search text: String) {
        if text.count>2{
            interactor?.searchMovies(search: text)
        }
    }
    
    
}
extension SearchPresenter:SearchInteractorToPresenter{
    
    func didSearchMovies(movies: [Movie]) {
        view?.displayMovies(movies:movies)
    }
    
}
