//
//  AllImagesForBreedVC.swift
//  Dogify
//
//  Created by RAGHAV SHARMA on 25/04/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

class AllImagesForBreedVC: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView : UITableView!
    var viewModel : AllImagesForBreedVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "DogBreedImageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "DogBreedImageTableViewCell")
        
        // Api Call
        viewModel?.getBreedImageList() { _ in
            self.tableView.reloadData()
        }
        
        navigationItemsHandeling()
    }
    
    @objc func closeButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigationItemsHandeling() {
        self.navigationItem.title = "\(viewModel?.breedName?.uppercased() ?? "")"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButton))
    }
    
}

extension AllImagesForBreedVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.imagesOfBreed?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DogBreedImageTableViewCell") as? DogBreedImageTableViewCell else {return UITableViewCell()}
        guard let imageName = viewModel?.imagesOfBreed?[indexPath.row] else {return UITableViewCell()}
        guard let url = URL(string: imageName) else {return UITableViewCell()}
        cell.imageViewBreed?.load(url: url)
        cell.imageViewBreed?.contentMode = .scaleAspectFill
        cell.imageViewBreed?.layer.cornerRadius = 100.0
        return cell
    }
}


