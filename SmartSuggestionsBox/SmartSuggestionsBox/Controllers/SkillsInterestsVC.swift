//
//  SkillsInterestsVC.swift
//  SmartSuggestionsBox
//
//  Created by RAGHAV SHARMA on 01/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

import UIKit

class SkillsInterestsVC: UIViewController {
    private var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    private var shuffledSkillsArray = [Skill]()
    private var suggestionsList = ["BasicOperators", "Strings", "Characters", "CollectionTypes", "ControlFlow", "Closures", "AdvancedOperators", "AccessControl", "Memory", "Generics", "Error", "Deinitialization","Boon","Banana"]
    private var suggestionsSkillsArray = [Skill]()
    private var correctSkillsArray = [Skill]()
    private var selectedItemstCollView: SkillsCollectionView!
    private var searchResultsCollView: SkillsCollectionView!
    private var searchResultsLbl : UIView?
    private var skillsAndInterestsSegment = UISegmentedControl()
    private var scrollView = UIScrollView.init()
    private var contentView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.view.backgroundColor = .white
        self.setupViews()
        self.fetchShuffledSkills()
        let _ = suggestionsList.map { (suggestion) in
            suggestionsSkillsArray.append(Skill(title: suggestion, id: UUID(), selected: false))
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 20.0
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupViews() {
        navigationItemsHandeling()
        
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = NSLayoutConstraint.init(item: contentView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
        heightConstraint.priority = UILayoutPriority.init(200)
        
        self.view.addSubview(scrollView)
        self.view.addConstraints([
            self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        self.scrollView.addSubview(contentView)
        let padding = self.navigationController?.navigationBar.frame.maxY ?? 0
        self.scrollView.addConstraints([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -1 * padding),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
        ])
        
        self.view.addConstraints([
            self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            heightConstraint,
        ])
        self.skillsAndInterestsSegment.selectedSegmentIndex = 0
        self.skillsAndInterestsSegment.insertSegment(withTitle: "Skills", at: 0, animated: true)
        self.skillsAndInterestsSegment.insertSegment(withTitle: "Interests", at: 1, animated: true)
        self.skillsAndInterestsSegment.translatesAutoresizingMaskIntoConstraints = false
        self.skillsAndInterestsSegment.addTarget(self, action:  #selector(segmentValueChanged), for:.valueChanged)
        self.contentView.addSubview( self.skillsAndInterestsSegment)
        self.skillsAndInterestsSegment.setupSegment()
        //  self.skillsAndInterestsSegment.addUnderlineForSelectedSegment()
        self.contentView.addConstraints([
            self.skillsAndInterestsSegment.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
            self.skillsAndInterestsSegment.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.skillsAndInterestsSegment.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        let searchTextFeild = UITextField()
        searchTextFeild.backgroundColor = #colorLiteral(red: 0.9355562329, green: 0.9287932515, blue: 0.9407340884, alpha: 1)
        searchTextFeild.translatesAutoresizingMaskIntoConstraints = false
        searchTextFeild.attributedPlaceholder = NSAttributedString(string: "Search For Skills like iOS,Swift,Objc",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                                                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14.0)])
        searchTextFeild.delegate = self
        
        self.contentView.addSubview(searchTextFeild)
        self.contentView.addConstraints([
            searchTextFeild.topAnchor.constraint(equalTo:  self.skillsAndInterestsSegment.bottomAnchor,constant: 10),
            searchTextFeild.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            searchTextFeild.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            searchTextFeild.heightAnchor.constraint(equalToConstant: 40.0)])
        let topLabel = returnLabel(with: "TopSkills")
        searchResultsLbl = returnLabel(with: "Search Results")
        
        self.selectedItemstCollView = returnCollView()
        self.selectedItemstCollView.register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: SkillCollectionViewCell.identifier)
        self.selectedItemstCollView.layer.cornerRadius = 5.0
        self.selectedItemstCollView.isDynamicSizeRequired = true
        if correctSkillsArray.count == 0 {
            self.selectedItemstCollView.isHidden = true
            topLabel.isHidden = true
        }
        if shuffledSkillsArray.count == 0 {
            self.searchResultsLbl?.isHidden = true
        }
        
        self.searchResultsCollView = returnCollView()
        self.searchResultsCollView.register(SkillListCollectionViewCell.self, forCellWithReuseIdentifier: SkillListCollectionViewCell.identifier)
        
        topLabel.setContentHuggingPriority(.init(rawValue: 800), for: .vertical)
        searchResultsLbl?.setContentHuggingPriority(.init(rawValue: 799), for: .vertical)
        let topStack = UIStackView(arrangedSubviews: [topLabel, selectedItemstCollView])
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.axis = .vertical
        topStack.spacing = 8.0
        
        let bottomStack = UIStackView(arrangedSubviews: [searchResultsLbl ?? UIView(), searchResultsCollView])
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.axis = .vertical
        
        self.contentView.addSubview(topStack)
        self.contentView.addSubview(bottomStack)
        
        self.contentView.addConstraints([
            
            topStack.topAnchor.constraint(equalTo: searchTextFeild.bottomAnchor,constant: 16),
            topStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            topStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            topStack.heightAnchor.constraint(greaterThanOrEqualToConstant: self.selectedItemstCollView.contentSize.height + 30),
            
            bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 16),
            bottomStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            bottomStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            bottomStack.heightAnchor.constraint(greaterThanOrEqualToConstant: self.searchResultsCollView.contentSize.height + 30)
        ])
    }
    
    func navigationItemsHandeling() {
        self.navigationItem.hidesBackButton = true
        
        let navBarTitle = UIBarButtonItem()
        navBarTitle.title = "Skills and Interests"
        navBarTitle.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18.0)], for: .normal)
        navBarTitle.action = nil
        navBarTitle.target = self
        navBarTitle.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let backItem = UIBarButtonItem()
        backItem.image = UIImage(systemName: "arrow.left")
        backItem.action = #selector(backPressed)
        backItem.target = self
        backItem.tintColor = .black
        navigationItem.leftBarButtonItems = [backItem,navBarTitle]
        
        let saveBtnItem = UIBarButtonItem()
        saveBtnItem.title = "Save"
        saveBtnItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14.0)], for: .normal)
        saveBtnItem.action = #selector(savePressed)
        saveBtnItem.target = self
        saveBtnItem.tintColor = #colorLiteral(red: 0, green: 0.1645387113, blue: 0.3128089607, alpha: 1)
        navigationItem.rightBarButtonItem = saveBtnItem
    }
    
    @objc func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func savePressed() {
        
    }
    @objc func segmentValueChanged() {
        self.skillsAndInterestsSegment.changeUnderlinePosition()
    }
    
    private func fetchShuffledSkills() {
        
        let spinner = Spinner.init()
        //   spinner.showInView(self.view, inBounds: self.view.bounds)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            // spinner.hide()
            
            self.searchResultsCollView.reloadData()
            self.searchResultsCollView.layoutIfNeeded()
        }
    }
    
    private func sendArrangedSkillsToRemote() {
        
        let alert = UIAlertController.init(title: "Sending", message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0, green: 0.1645387113, blue: 0.3128089607, alpha: 1)
        alert.addAction(.init(title: "Cancel", style: .default, handler: nil))
        alert.addAction(.init(title: "Continue", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func onClickOfButtons(_ sender: UIButton) {
        
        self.sendArrangedSkillsToRemote()
    }
    
    private func returnLabel(with text: String) -> UILabel {
        
        let labl = UILabel()
        labl.text = text
        labl.font = UIFont.systemFont(ofSize: 16)
        labl.numberOfLines = 0
        labl.textColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        labl.translatesAutoresizingMaskIntoConstraints = false
        return labl
    }
    
    private func returnCollView() -> SkillsCollectionView {
        
        let layout = CustomViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let collView = SkillsCollectionView.init(frame: .zero, collectionViewLayout: layout)
        collView.translatesAutoresizingMaskIntoConstraints = false
        //    collView.isScrollEnabled = false
        collView.delegate = self
        collView.dataSource = self
        collView.backgroundColor = .clear
        return collView
    }
}

extension SkillsInterestsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //Datasource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView === selectedItemstCollView {
            return correctSkillsArray.count
        } else {
            return shuffledSkillsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView === selectedItemstCollView {
            self.selectedItemstCollView.isHidden = false
            guard let cell = self.selectedItemstCollView.dequeueReusableCell(withReuseIdentifier: SkillCollectionViewCell.identifier, for: indexPath) as? SkillCollectionViewCell else { return SkillCollectionViewCell() }
            let skill = self.correctSkillsArray[indexPath.item]
            cell.skill = skill
            return cell
        } else {
            
            guard let cell = self.searchResultsCollView.dequeueReusableCell(withReuseIdentifier: SkillListCollectionViewCell.identifier, for: indexPath) as? SkillListCollectionViewCell else { return SkillListCollectionViewCell() }
            let skill = self.shuffledSkillsArray[indexPath.item]
            cell.skill = skill
            cell.backgroundColor = skill.selected ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return cell
        }
    }
    
    //Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView === selectedItemstCollView {
            //Delete from top and enable the same in the bottom coll view
            var skill = self.correctSkillsArray[indexPath.item]
            for (index,reqSkill) in self.correctSkillsArray.enumerated() {
                if reqSkill.id == skill.id {
                    self.correctSkillsArray.remove(at: index)
                }
            }
            for (index,reqSkill) in self.shuffledSkillsArray.enumerated() {
                if reqSkill.id == skill.id {
                    self.shuffledSkillsArray.remove(at: index)
                    skill.selected = false
                    self.shuffledSkillsArray.insert(skill, at: index)
                }
            }
            self.selectedItemstCollView.reloadData()
            self.selectedItemstCollView.layoutIfNeeded()
            self.searchResultsCollView.reloadData()
            self.searchResultsCollView.layoutIfNeeded()
            
        } else {
            //Bot CollView
            var isSkillPresent = false
            var skill = self.shuffledSkillsArray[indexPath.item]
            let _ = self.correctSkillsArray.map { (item) in
                if item.title == skill.title {
                    isSkillPresent = true
                }
            }
            if !skill.selected {
                if !isSkillPresent {
                    skill.selected = true
                    self.correctSkillsArray.append(skill)
                    self.shuffledSkillsArray.remove(at: indexPath.item)
                    self.shuffledSkillsArray.insert(skill, at: indexPath.item)
                    self.selectedItemstCollView.reloadData()
                    self.selectedItemstCollView.layoutIfNeeded()
                    self.searchResultsCollView.reloadData()
                    self.searchResultsCollView.layoutIfNeeded()
                }
            } else {
                for (index,reqSkill) in self.correctSkillsArray.enumerated() {
                    if reqSkill.id == skill.id {
                        self.correctSkillsArray.remove(at: index)
                    }
                }
                skill.selected = false
                self.shuffledSkillsArray.remove(at: indexPath.item)
                self.shuffledSkillsArray.insert(skill, at: indexPath.item)
                self.selectedItemstCollView.reloadData()
                self.selectedItemstCollView.layoutIfNeeded()
                self.searchResultsCollView.reloadData()
                self.searchResultsCollView.layoutIfNeeded()
            }
        }
        
        if correctSkillsArray.count > 0 {
            self.selectedItemstCollView.isHidden = false
        } else {
            self.selectedItemstCollView.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var text = ""
        
        if collectionView === selectedItemstCollView {
            let skill = self.correctSkillsArray[indexPath.item]
            text = skill.title
        } else {
            let skill = self.shuffledSkillsArray[indexPath.item]
            text = skill.title
        }
        
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:16.0)]).width + 30.0
        
        if collectionView === selectedItemstCollView {
            return CGSize(width: min(cellWidth + 35, selectedItemstCollView.contentSize.width - 16), height: 30.0)
        } else {
            return CGSize(width: cellWidth, height: 30.0)
        }
    }
    
}

extension SkillsInterestsVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !autoCompleteText( in : textField, using: string,suggestionsSkillsArray)
    }
    
    func autoCompleteText( in textField: UITextField, using string: String, _ suggestionSkills: [Skill]) -> Bool {
        if !string.isEmpty,
            let selectedTextRange = textField.selectedTextRange,
            selectedTextRange.end == textField.endOfDocument,
            let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
            let text = textField.text( in : prefixRange) {
            let prefix = text + string
            self.shuffledSkillsArray.removeAll()
            let matches = suggestionSkills.filter {
                $0.title.lowercased().contains(prefix.lowercased())
            }
            if (matches.count > 0) {
                self.shuffledSkillsArray.append(contentsOf: matches)
                self.searchResultsCollView.reloadData()
                self.searchResultsLbl?.isHidden = false
                textField.text = prefix
                if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                }
                return true
            }
        }
        self.shuffledSkillsArray.removeAll()
        self.searchResultsCollView.reloadData()
        return false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

