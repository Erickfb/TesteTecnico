//
//  UIViewController+Utils.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 19/08/24.
//

import UIKit

extension UIViewController {
    func showRetryErrorAlert(on viewController: UIViewController,
                             withTitle title: String,
                             message: String,
                             retryHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Tentar Novamente", style: .default) { _ in
            retryHandler()
        }

        let cancelAction = UIAlertAction(title: "Fechar", style: .cancel) { _ in
            exit(0)
        }

        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
