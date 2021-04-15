//
//  ListContracts.swift
//  TheMovieDB
//
//  Created by Bekir Yeşilkaya on 13.04.2021.
//

import Foundation
import UIKit
protocol ListViewToPresenter {
    var view:ListPresenterToView? {get set}
    var interactor : ListPresenterToInteractor? {get set}
    var router : ListPresenterToWireFrame? {get set}
    
    func viewDidload()
}

protocol ListPresenterToInteractor {
    
    var presenter:ListInteractorToPresenter? {get set}
    
    func getNowPlayings()
    func getUpComings()
}

protocol ListInteractorToPresenter {
    func didGetNowPlayings(movies:[Movie])
    func didGetUpComings(movies:[Movie])
    func didGetError(error:APIError)
    func didCompleted()
}

protocol ListPresenterToWireFrame:BaseWireframe{
    func goToDetail(from view:ListPresenterToView,movie:Movie)
    func openSearch()
}

protocol ListPresenterToView {
    func displayNowPlayings(movies:[Movie])
    func displayUpcomings(movies:[Movie])
    func displayError(error:APIError)
    func displayLoading(status:Bool)
}

