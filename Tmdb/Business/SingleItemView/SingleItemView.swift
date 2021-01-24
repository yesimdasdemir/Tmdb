//
//  SingleItemView.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 22.01.2021.
//

import UIKit

final class SingleItemView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    private let cornerRadiusValue: CGFloat = 10.0
    
    // MARK: Initialize methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    var viewModel: SingleItemViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            initView(viewModel: viewModel)
        }
    }
    
    private func initView(viewModel: SingleItemViewModel) {
        
        if let imageLink = viewModel.imageLink, let url = URL(string: imageLink) {
            load(url: url)
        }
        
        let userDefaults = UserDefaults.standard
        
        if let favArray: [Int] = userDefaults.array(forKey: "favoriteMoviesArray") as? [Int], let id = viewModel.id, favArray.contains(id) {
            favoriteImageView.image = UIImage(named: "starFilled")
        } else {
            favoriteImageView.image = UIImage(named: "star")
        }
        
        imageView.layer.cornerRadius = cornerRadiusValue
        imageView.clipsToBounds = true
        
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
    }
    
    private func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: LoadNib
    
    private func loadNib() {
        let nibName = String(describing: type(of: self))
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(contentView)
    }
}
