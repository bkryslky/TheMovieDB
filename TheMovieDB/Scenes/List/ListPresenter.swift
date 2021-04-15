//
//  ListPresenter.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation

class ListPresenter:ListViewToPresenter{
    var view: ListPresenterToView?
    
    var interactor: ListPresenterToInteractor?
    
    var router: ListPresenterToWireFrame?
    

    func viewDidload() {
        view?.displayLoading(status: true)
        interactor?.getNowPlayings()
        interactor?.getUpComings()
    }
    
    func goToDetail(movie:Movie){
        router?.goToDetail(from:view! , movie: movie)
    }
    
    func goToSearch(){
        router?.openSearch()
    }

    
    
}
extension ListPresenter:ListInteractorToPresenter{
  
    
    func didGetNowPlayings(movies: [Movie]) {
        view?.displayNowPlayings(movies: movies)
    }
    
    func didGetUpComings(movies: [Movie]) {
        view?.displayUpcomings(movies:movies)
    }
    
    func didGetError(error: APIError) {
        view?.displayError(error: error)
    }
    
    func didCompleted() {
        view?.displayLoading(status: false)
    }
    
    
    
}
