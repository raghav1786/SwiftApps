//
//  ViewController.swift
//  CollectionViewBasics
//
//  Created by RAGHAV SHARMA on 02/05/20.
//  Copyright © 2020 RAGHAV SHARMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate {
    @IBOutlet weak var collectView : UICollectionView!
    var items = ["Te","Test","Testshhhhhj","Testshq","Tsdf","Testshhsj1","Testsdsd","Testshqdghasjgahsj1","Test2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectView.dataSource = self
        self.collectView.delegate = self
        self.collectView.register(UINib(nibName: "ReusableCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ReusedCell")
        self.layoutCells()
            //items = items.sorted()
        self.collectView.reloadData()
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusedCell", for: indexPath) as? ReusableCell else {return UICollectionViewCell()}
        cell.title?.text = items[indexPath.row]
        cell.title?.textColor = .white
        cell.title?.sizeToFit()
        let crossImage =  UIImage(systemName: "xmark.circle")
        cell.crossImageView?.image = crossImage
        cell.crossImageView?.contentMode = .scaleAspectFill
        cell.contentView.layer.cornerRadius = 24.0
        return cell
    }
    
    func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5.0
        layout.collectionView?.contentMode = .scaleAspectFit
        layout.minimumLineSpacing = 10.0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectView!.collectionViewLayout = layout
    }
    
}


//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // dataArary is the managing array for your UICollectionView.
//        let item = items[indexPath.row]
//        let itemSize = item.size(withAttributes: [
//            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
//        ])
//        return itemSize
//    }
//}
