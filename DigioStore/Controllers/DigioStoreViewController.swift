//
//  DigioStoreViewController.swift
//  DigioStore
//
//  Created by Erick Fernandes Batista on 17/08/24.
//

import UIKit

class DigioStoreViewController: UITableViewController {
    
    var storeData: DigioStore?
    var digioStoreService = DigioStoreService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UserHeaderCell.self, forCellReuseIdentifier: "UserHeaderCell")
        tableView.register(SpotlightCell.self, forCellReuseIdentifier: "SpotlightCell")
        tableView.register(CashCell.self, forCellReuseIdentifier: "CashCell")
        tableView.register(ProductsCell.self, forCellReuseIdentifier: "ProductsCell")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        
        fetchData()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func fetchData() {
        digioStoreService.fetchStoreData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.storeData = data
                    self.tableView.reloadData()
                case .failure(let error):
                    self.showRetryErrorAlert(on: self, withTitle: "Erro", message: error.localizedDescription) {
                        self.fetchData()
                    }
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeaderCell", for: indexPath) as? UserHeaderCell else {
                return UITableViewCell()
            }
            cell.configure(with: "Maria", icon: UIImage(named: "userIcon"))
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpotlightCell", for: indexPath) as? SpotlightCell else {
                return UITableViewCell()
            }
            if let spotlightItems = storeData?.spotlight {
                cell.configure(with: spotlightItems)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CashCell", for: indexPath) as? CashCell else {
                return UITableViewCell()
            }
            if let cash = storeData?.cash {
                cell.configure(with: cash)
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell", for: indexPath) as? ProductsCell else {
                return UITableViewCell()
            }
            if let productItems = storeData?.products {
                cell.configure(with: productItems)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 2, 3:
            return 150
        default:
            return 220
        }
    }
}
