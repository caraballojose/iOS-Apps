//
//  ViewController.swift
//  Carousel
//
//  Created by Jose Caraballo on 6/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(viewModels: [
            TileCollectionTableViewCellViewModel(name: "Apple", backgroundColor: .systemRed),
            TileCollectionTableViewCellViewModel(name: "Google", backgroundColor: .systemBlue),
            TileCollectionTableViewCellViewModel(name: "Nvidia", backgroundColor: .systemPink),
            TileCollectionTableViewCellViewModel(name: "Intel", backgroundColor: .systemGray),
            TileCollectionTableViewCellViewModel(name: "AMD", backgroundColor: .systemGreen),
            TileCollectionTableViewCellViewModel(name: "Microsoft", backgroundColor: .systemYellow)
        ])
    ]

    let myTableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
        myTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: view.frame.height/2)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel =  viewModels[indexPath.row]
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell
        else { fatalError() }
        cell.textLabel?.text = "Testing"
        cell.delegatee = self
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width/2
    }
    
}

//Mark:- Protocol

extension ViewController: CollectionTableViewCellDelagate {
    func collectionTableViewCellDidTapItem(with viewModel: TileCollectionTableViewCellViewModel) {
        let alert = UIAlertController(title: viewModel.name, message: "You successfully got the selected item!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
}

