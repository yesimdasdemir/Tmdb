//
//  CustomCollectionViewCell.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 20.01.2021.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var singleItemView: SingleItemView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with model: SingleItemViewModel?) {
        singleItemView?.viewModel = model
    }
}
