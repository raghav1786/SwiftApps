//
//  CategoryVC.swift
//
//  Created by RAGHAV SHARMA on 14/04/21.
//

import UIKit
import CoreData

class CategoryVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var categories = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UINib(nibName: "CategoryCell", bundle: Bundle.main), forCellReuseIdentifier: "CategoryCell")
        if let categories = CoreDataManager.shared.retrieve(entityClass: Category.self) {
            self.categories = categories
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Category List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked() {
        self.performSegue(withIdentifier: "detailsClicked", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsClicked" {
            if let detailsVC = segue.destination as? CategoryDetailsVC {
                detailsVC.delegate = self
            }
        }
    }
}


extension CategoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell else { return UITableViewCell() }
        let category = categories[indexPath.row]
        cell.categoryLabel?.text = category.name
        if let subcategory = category.subcategory, !subcategory.isEmpty {
            cell.subcategoryLabel?.text = subcategory
            cell.subcategoryTitleLabel?.text = "SubCategory:"
            cell.subcategoryLabel?.isHidden = false
            cell.subcategoryStack?.isHidden = false
            cell.subcategoryTitleLabel?.isHidden = false
        } else {
            cell.subcategoryStack?.isHidden = true
            cell.subcategoryLabel?.isHidden = true
            cell.subcategoryTitleLabel?.isHidden = true
        }
        cell.separatorView.isHidden = indexPath.row == categories.count-1 ? true : false
        return cell
    }
}

extension CategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CoreDataManager.shared.managedObjectContext.delete(categories[indexPath.row])
        categories.remove(at: indexPath.row)
        CoreDataManager.shared.saveContext()
        tableView.reloadData()
    }
}


extension CategoryVC: CategoryData {
    func addedCategory(category: Category) {
        self.categories.append(category)
        self.tableView.reloadData()
        CoreDataManager.shared.saveContext()
    }
}
