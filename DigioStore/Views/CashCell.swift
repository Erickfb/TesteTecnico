//
//  CashCell.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 17/08/24.
//

import UIKit

class CashCell: UITableViewCell {
    let titleLabel = UILabel()
    let cashBannerImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func setupUI() {
        titleLabel.text = "digio Cash"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        cashBannerImageView.contentMode = .scaleToFill
        cashBannerImageView.layer.cornerRadius = 16
        cashBannerImageView.clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, cashBannerImageView])
        cashBannerImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with cash: Cash) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        tapGestureRecognizer.cash = cash
        cashBannerImageView.isUserInteractionEnabled = true
        cashBannerImageView.addGestureRecognizer(tapGestureRecognizer)
        
        cashBannerImageView.loadImage(from: cash.bannerURL)
    }
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let cash = sender.cash else { return }
        
        let detailViewController = DetailViewController(detailModel: DetailModel(
            name: cash.title,
            imageUrl: cash.bannerURL,
            description: cash.description
        ))
        
        parentViewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
