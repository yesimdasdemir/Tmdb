//
//  SingleItemView.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 22.01.2021.
//

import UIKit

final class SingleItemView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    
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
        
        if let imageLink = viewModel.imageLink,let url = URL(string: imageLink) {
            load(url: url)
        }
                
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
                
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
    }
    
    func load(url: URL) {
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
