//
//  FaceoutCollectionViewCell.swift
//  FaceoutTests
//
//  Created by Bryan Morfe on 5/7/22.
//

import UIKit

protocol FaceoutCollectionViewCellDelegate {
    func faceoutCollectionViewCellDidFinishDisplayingContent(_ cell: FaceoutCollectionViewCell)
}

class FaceoutCollectionViewCell: UICollectionViewCell {
    public var item: FaceoutItem? {
        set {
            faceoutView.item = newValue
        }
        get {
            return faceoutView.item
        }
    }
    public var delegate: FaceoutCollectionViewCellDelegate?
    private lazy var faceoutView = faceoutViewInit()
    private lazy var bottomButton = button()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.addSubview(faceoutView)
        contentView.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            faceoutView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            faceoutView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            faceoutView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            bottomButton.topAnchor.constraint(greaterThanOrEqualTo: faceoutView.bottomAnchor, constant: 8),
            bottomButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            bottomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            bottomButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.size.width, height: 0)
        let modifiedAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        modifiedAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return modifiedAttributes
    }
}

extension FaceoutCollectionViewCell {
    func faceoutViewInit() -> FaceoutView {
        let view = FaceoutView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.itemCompletionHandler = {
            self.delegate?.faceoutCollectionViewCellDidFinishDisplayingContent(self)
        }
        return view
    }
    
    func button() -> UIButton {
        let btn = UIButton(configuration: .borderedProminent())
        btn.setTitle("Buy", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
}
