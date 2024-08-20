//
//  SpotlightCell.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 17/08/24.
//

import UIKit

class SpotlightCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView
    var spotlightItems: [Spotlight] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SpotlightCollectionViewCell.self, forCellWithReuseIdentifier: "SpotlightCollectionViewCell")
        
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configure(with items: [Spotlight]) {
        self.spotlightItems = items
    }
}

extension SpotlightCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSpotlight = spotlightItems[indexPath.item]
        let detailViewController = DetailViewController(detailModel: DetailModel(name: selectedSpotlight.name,
                                                                                 imageUrl: selectedSpotlight.bannerURL,
                                                                                 description: selectedSpotlight.description))
        parentViewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spotlightItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpotlightCollectionViewCell", 
                                                            for: indexPath) as? SpotlightCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let spotlight = spotlightItems[indexPath.item]
        cell.configure(with: spotlight)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 200)
    }
}
