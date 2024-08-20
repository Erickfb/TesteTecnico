//
//  UserCell.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 17/08/24.
//

import UIKit

class UserHeaderCell: UITableViewCell {
    let userIconImageView = UIImageView()
    let userNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func setupUI() {
        userIconImageView.contentMode = .scaleAspectFit
        userNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        let stackView = UIStackView(arrangedSubviews: [userIconImageView, userNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userIconImageView.widthAnchor.constraint(equalToConstant: 30),
            userIconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with userName: String, icon: UIImage?) {
        userNameLabel.text = "Olá, \(userName)"
        userIconImageView.image = icon
    }
}
