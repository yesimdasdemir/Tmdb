//
//  SimpleDetailViewModel.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 24.01.2021.
//

import Foundation

struct SimpleDetailViewModel {
    let title: String?
    let description: String?
    let voteCount: Int?
    let imageWidth: String
    let posterPath: String?
    var imageLink: String?
    
    init(title: String? = nil, description: String? = nil, voteCount: Int? = nil, imageWidth: String = "200", posterPath: String? = "") {
        
        self.title = title
        self.description = description
        self.voteCount = voteCount
        self.imageWidth = imageWidth
        self.posterPath = posterPath
        
        if let posterPath = posterPath {
            self.imageLink = "https://image.tmdb.org/t/p/w" + imageWidth + posterPath
        } else {
            self.imageLink = nil
        }
    }
}
