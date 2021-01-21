//
//  MovieListInteractor.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 21.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieListBusinessLogic {
  func doSomething(request: MovieList.Something.Request)
}

protocol MovieListDataStore {
  //var name: String { get set }
}

class MovieListInteractor: MovieListBusinessLogic, MovieListDataStore {
  var presenter: MovieListPresentationLogic?
  var worker: MovieListWorker?
  //var name: String = ""
    
  func doSomething(request: MovieList.Something.Request) {
    worker = MovieListWorker()
    worker?.doSomeWork()
    
    let response = MovieList.Something.Response()
    presenter?.presentSomething(response: response)
  }
}