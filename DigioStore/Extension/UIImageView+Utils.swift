//
//  UIImageView+Utils.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 19/08/24.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.image = UIImage(named: "alert")
            }
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "alert")
                }
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }
}
