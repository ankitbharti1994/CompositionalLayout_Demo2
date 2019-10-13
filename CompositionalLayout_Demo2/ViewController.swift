//
//  ViewController.swift
//  CompositionalLayout_Demo2
//
//  Created by ankit bharti on 13/10/19.
//  Copyright © 2019 ankit kumar bharti. All rights reserved.
//

import UIKit

fileprivate let REUSE_IDENTIFIER = "Cell"

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var dataSource = createDataSource()
    
    enum Section: Int, CaseIterable {
        case first
        case second
        case third
        case fourth
        case fifth
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        self.collectionView.register(UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: REUSE_IDENTIFIER)
        self.collectionView.dataSource = dataSource
        self.collectionView.collectionViewLayout = createLayout()
        self.updateCollectionView()
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, Int> {
        return UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView) { (cv, indexPath, value) -> UICollectionViewCell? in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath) as? CollectionViewCell
            
            cell?.configure("\(indexPath.section), \(indexPath.item)")
            
            return cell
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0))
        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        
        let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
        trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        
        
        let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0))
        
        let trailingItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitem: trailingItem, count: 2)
        
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.4)), subitems: [leadingItem, trailingItemGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func updateCollectionView(animation: Bool = true) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections(Section.allCases)
        
        snapShot.appendItems(Array(0..<100), toSection: .first)
        snapShot.appendItems(Array(100..<200), toSection: .second)
        snapShot.appendItems(Array(200..<300), toSection: .third)
        snapShot.appendItems(Array(300..<400), toSection: .fourth)
        snapShot.appendItems(Array(400..<500), toSection: .fifth)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

