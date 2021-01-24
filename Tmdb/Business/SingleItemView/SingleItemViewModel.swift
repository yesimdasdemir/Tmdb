//
//  SingleItemViewModel.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 22.01.2021.
//

import Foundation

struct SingleItemViewModel {
    let id: Int?
    let title: String?
    let subTitle: String?
    let imageWidth: String
    let posterPath: String?
    var imageLink: String?
    
    init(id: Int? = nil, title: String? = nil, subTitle: String? = nil, imageWidth: String = "200", posterPath: String? = "") {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.imageWidth = imageWidth
        self.posterPath = posterPath
       
        if let posterPath = posterPath {
            self.imageLink = "https://image.tmdb.org/t/p/w" + imageWidth + posterPath
        } else {
            self.imageLink = nil
        }
    }
}

