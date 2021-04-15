//
//  ViewController.swift
//  TableViewCRUD
//
//  Created by RAGHAV SHARMA on 14/04/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var categories = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
        if let categories = CoreDataManager.shared.retrieve(entityClass: Category.self) {
            self.categories = categories
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked() {
        alertWithTextField(title: "Please add Category", message: "", placeholder: "Category Name") { result in
            if let result = result {
                let newCategory = Category(context: CoreDataManager.shared.managedObjectContext)
                newCategory.name = result
                self.categories.append(newCategory)
                self.tableView.reloadData()
                CoreDataManager.shared.saveContext()
            }
        }
    }
    
    public func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String?) -> Void) = { _  in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) {
            _ in
        })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) {
            action in
            if let textFields = alert.textFields,
                let textFieldFirst = textFields.first,
                let result = textFieldFirst.text {
                completion(result)
            } else {
                completion(nil)
            }
        })
        self.navigationController?.present(alert,animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CoreDataManager.shared.managedObjectContext.delete(categories[indexPath.row])
        categories.remove(at: indexPath.row)
        CoreDataManager.shared.saveContext()
        tableView.reloadData()
    }
}

