//
//  SimpleDetailView.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 24.01.2021.
//

import UIKit

final class SimpleDetailView: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let nibName = String(describing: CustomCollectionViewCell.self)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    var viewModel: SimpleDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            initView(viewModel: viewModel)
        }
    }
    
    private func initView(viewModel: SimpleDetailViewModel) {
        
        if let url = URL(string: viewModel.imageLink) {
            load(url: url)
        }
                
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
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
    
    // MARK: Nib
    
    private func loadNib() {
        let nibName = String(describing: type(of: self))
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
