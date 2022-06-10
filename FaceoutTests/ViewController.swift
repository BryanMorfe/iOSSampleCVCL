//
//  ViewController.swift
//  FaceoutTests
//
//  Created by Bryan Morfe on 5/7/22.
//

import UIKit

class ViewController: UIViewController {
    lazy var collectionViewLayout = collectionViewLayoutInit()
    lazy var collectionView = collectionViewInit()
    lazy var dataSource = dataSourceInit()
    var shouldPerformsEmptyBatchUpdates = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        addMockData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if shouldPerformsEmptyBatchUpdates {
            dataSource.apply(dataSource.snapshot(), animatingDifferences: true)
            shouldPerformsEmptyBatchUpdates = false
        }
    }
}

// MARK: Collection View Initializers
extension ViewController {
    func collectionViewLayoutInit() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .estimated(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
    }
    
    func collectionViewInit() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    func dataSourceInit() -> UICollectionViewDiffableDataSource<String, FaceoutItem> {
        let cellRegistration = UICollectionView.CellRegistration<FaceoutCollectionViewCell, FaceoutItem> { cell, indexPath, itemIdentifier in
            cell.delegate = self
            cell.coordinator = self
            Task {
                try? await Task.sleep(nanoseconds:1_500_000_000)
                cell.item = itemIdentifier
            }
        }
        let dataSource = UICollectionViewDiffableDataSource<String, FaceoutItem>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }
}

// MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: Mock Data
extension ViewController {
    func addMockData() {
        var snapshot = NSDiffableDataSourceSnapshot<String, FaceoutItem>()
        let items = [
            FaceoutItem(
                imageURL: URL(string: "https://thumbs.dreamstime.com/b/cherry-blossoms-korea-beautiful-34712339.jpg")!,
                itemID: "someID0",
                title: "Bryan Morfe",
                priceString: "$9.99"
            ),
            FaceoutItem(
                imageURL: URL(string: "https://wallpapercave.com/wp/j7c1FtS.jpg")!,
                itemID: "someID1",
                title: "Bryan Morfe",
                priceString: "$9.99"
            ),
            FaceoutItem(
                imageURL: URL(string: "https://images.unsplash.com/photo-1525673812761-4e0d45adc0cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bmljZSUyMHBob3RvfGVufDB8fDB8fA%3D%3D&w=1000&q=80")!,
                itemID: "someID2",
                title: "Bryan Morfe",
                priceString: "$11.99",
                orientation: .portrait
            ),
            FaceoutItem(
                imageURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8FYQtQh_p7QGeiCcN3CnnZpbKxfl5Z4tLdA&usqp=CAU")!,
                itemID: "someID3",
                title: "Bryan Morfe",
                priceString: "$12.99"
            ),
            FaceoutItem(
                imageURL: URL(string: "https://cdn.wallpapersafari.com/8/55/wZobKJ.jpg")!,
                itemID: "someID4",
                title: "Bryan Morfe",
                priceString: "$14.49"
            ),
            FaceoutItem(
                imageURL: URL(string: "https://images.unsplash.com/photo-1503696967350-ad1874122058?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bmljZXxlbnwwfHwwfHw%3D&w=1000&q=80")!,
                itemID: "someID5",
                title: "Bryan Morfe",
                priceString: "$14.99",
                orientation: .portrait
            ),
            FaceoutItem(
                imageURL: URL(string: "https://w0.peakpx.com/wallpaper/704/984/HD-wallpaper-nice-nice-thumbnail.jpg")!,
                itemID: "someID6",
                title: "Bryan Morfe",
                priceString: "$19.99"
            ),
            FaceoutItem(
                imageURL: URL(string: "https://www.enjpg.com/img/2020/nice-36.jpg")!,
                itemID: "someID7",
                title: "Bryan Morfe",
                priceString: "$24.99",
                orientation: .portrait
            ),
            FaceoutItem(
                imageURL: URL(string: "https://cdn1.sportngin.com/attachments/text_block/387e-136709621/travel.png")!,
                itemID: "someID8",
                title: "Bryan Morfe",
                priceString: "$34.99"
            ),
            FaceoutItem(
                imageURL: URL(string: "https://cdn.kimkim.com/files/a/images/aff63655ebe13cd1224939c1308277de2bfb8eb3/big-56ef69ccefe7caae3c3f4c5e9c44b206.jpg")!,
                itemID: "someID9",
                title: "Bryan Morfe",
                priceString: "$39.99"
            ),
        ]
        snapshot.appendSections(["main"])
        snapshot.appendItems(items, toSection: "main")
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: FaceoutCollectionViewCellDelegate {
    func faceoutCollectionViewCellDidFinishDisplayingContent(_ cell: FaceoutCollectionViewCell) {
        shouldPerformsEmptyBatchUpdates = true
        view.setNeedsLayout()
    }
}

extension ViewController: CollectionViewLayoutAttributesCoordinator {
    func preferredLayoutAttributes(for cell: UICollectionViewCell, fitting layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if let indexPath = collectionView.indexPath(for: cell) {
            let neighbor = IndexPath(item: indexPath.item % 2 == 0 ? indexPath.item + 1 : indexPath.item - 1, section: indexPath.section)
            if let neighhborAttributes = collectionView.layoutAttributesForItem(at: neighbor) {
                let maxHeight = max(layoutAttributes.size.height, neighhborAttributes.size.height)
                layoutAttributes.frame.size.height = maxHeight
            }
        }
        return layoutAttributes
    }
}
