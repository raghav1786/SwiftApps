//
//  CategoryDetailsVC.swift
//  CategoryDetails
//
//  Created by RAGHAV SHARMA on 17/04/21.
//

import UIKit
protocol CategoryData: AnyObject {
    func addedCategory(category: Category)
}


class CategoryDetailsVC: UIViewController {
    @IBOutlet weak var subcategoryTxtField: UITextField!
    @IBOutlet weak var categoryTxtField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var categoryData: String?
    weak var delegate: CategoryData?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        categoryTxtField.text = categoryData
    }

    @IBAction func submitBtnClicked(_ sender: Any) {
        guard !(categoryTxtField.text?.isEmpty ?? true ) else {
            return
        }
        let newCategory = Category(context: CoreDataManager.shared.managedObjectContext)
        newCategory.name = categoryTxtField.text
        newCategory.subcategory = subcategoryTxtField.text
        delegate?.addedCategory(category: newCategory)
        navigationController?.popToRootViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}
