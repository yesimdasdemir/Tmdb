//
//  MovieListModels.swift
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

enum GetMovieList {
    // MARK: Use cases
    
    enum MovieList {
        struct Request: Codable {
            let apiKey: String
            let transactionUrl: String
            let language: String
            let page: Int
            
            enum CodingKeys: String, CodingKey {
                case apiKey = "api_key"
                case transactionUrl
                case language
                case page
            }
            
            init(page: Int) {
                self.apiKey = "fd2b04342048fa2d5f728561866ad52a"
                self.language = "en-US"
                self.transactionUrl = "https://api.themoviedb.org/3/movie/popular?language=&api_key=" + String(describing: self.apiKey) + String(page)
                self.page = page
            }
        }
        
        struct Response: Codable {
            let page: Int?
            let totalPages: Int?
            let totalResults: Int?
            let results: [MovieListItem]?
            
            enum CodingKeys: String, CodingKey {
                case page
                case totalResults = "total_results"
                case totalPages = "total_pages"
                case results
            }
        }
        
        struct ViewModel {
            
        }
    }
}

struct MovieListItem: Codable {
    let id: Int?
    let posterPath: String?
    let releaseDate: String?
    let originalTitle: String
    let overview: String?
    let title: String?
    let voteAverage: Float?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case overview
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
