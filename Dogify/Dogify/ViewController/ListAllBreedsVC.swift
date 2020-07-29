//
//  ListAllBreedsVC.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 23/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

class ListAllBreedsVC: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    var viewModel : ListAllBreedsVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListAllBreedsVM()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        viewModel?.getDogData() { _ in
            self.tableView.reloadData()
        }
    }


}


extension ListAllBreedsVC : UITableViewDelegate {
    
}


extension ListAllBreedsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.listOfBreeds?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = viewModel?.listOfBreeds?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(identifier: "AllImagesForBreedVC") as? AllImagesForBreedVC else {return}
        let allImagesViewModel = AllImagesForBreedVM()
        allImagesViewModel.breedName = viewModel?.listOfBreeds?[indexPath.row]
        viewController.viewModel = allImagesViewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
