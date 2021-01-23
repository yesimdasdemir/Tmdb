//
//  MovieItemView.swift
//  Tmdb
//
//  Created by Yeşim Daşdemir on 22.01.2021.
//

import UIKit

protocol MovieItemViewProtocol: AnyObject {
    func didSelectRow(with id: Int)
}

final class MovieItemView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var collectionViewDelegate: MovieItemViewProtocol?
    
    private let nibName = String(describing: CustomCollectionViewCell.self)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        initCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        initCollectionView()
    }
    
    var viewModel: [SingleItemViewModel]? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            collectionView.reloadData()
        }
    }
    
    private func initCollectionView() {
        collectionView.register(UINib(nibName: nibName, bundle: Bundle(for: Self.self)), forCellWithReuseIdentifier: nibName)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func loadNib() {
        let nibName = String(describing: type(of: self))
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(contentView)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewDelegate?.didSelectRow(with: indexPath.row)
    }
}

extension MovieItemView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath) as! CustomCollectionViewCell
        if let viewModel = viewModel, !viewModel.isEmpty {
            cell.configure(with: viewModel[indexPath.row])
        }
        return cell
    }
}

extension MovieItemView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }

}
