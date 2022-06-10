//
//  CollectionViewLayoutAttributesCoordinator.swift
//  FaceoutTests
//
//  Created by Bryan Morfe on 6/9/22.
//

import UIKit

protocol CollectionViewLayoutAttributesCoordinator {
    func preferredLayoutAttributes(for cell: UICollectionViewCell, fitting layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
}
