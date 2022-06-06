//
//  FaceoutView.swift
//  FaceoutTests
//
//  Created by Bryan Morfe on 5/7/22.
//

import UIKit

class FaceoutView: UIView {
    public var item: FaceoutItem? {
        didSet {
            Task {
                await configure()
                itemCompletionHandler?()
                layoutIfNeeded()
            }
        }
    }
    public var itemCompletionHandler: (() -> Void)?
    
    private lazy var imageViewContainer = imageContainer()
    private lazy var imageView = imgView()
    private lazy var stackView = stackViewInit()
    private lazy var titleLabel = titleLabelInit()
    private lazy var priceLabel = priceLabelInit()
    private var imageViewContainerHeightConstraint: NSLayoutConstraint?
    
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
    
    func initialize() {
        addSubview(imageViewContainer)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageViewContainer.topAnchor.constraint(equalTo: topAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private extension FaceoutView {
    func imageContainer() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        view.backgroundColor = .lightGray
        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        
        imageViewContainerHeightConstraint = view.heightAnchor.constraint(equalToConstant: 200)
        imageViewContainerHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            imageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
        ])
        return view
    }
    
    func imgView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        return view
    }
    
    func titleLabelInit() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }
    
    func priceLabelInit() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        return label
    }
    
    func stackViewInit() -> UIStackView {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            priceLabel
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 6.0
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }
}

private extension FaceoutView {
    func configure() async {
        titleLabel.text = item?.title
        priceLabel.text = item?.priceString
        if let item = item {
            if item.orientation == .portrait {
                imageViewContainerHeightConstraint?.constant = 300
            } else {
                imageViewContainerHeightConstraint?.constant = 200
            }
            layoutIfNeeded()
            do {
                let (data, _) = try await URLSession.shared.data(from: item.imageURL)
                imageView.image = UIImage(data: data)
            } catch {
                print("Failed to download image with URL \(item.imageURL.absoluteString)")
            }
        } else {
            imageView.image = nil
            layoutIfNeeded()
        }
    }
}

extension UIImage {
    var orientation: UIImage.Orientation {
        get {
            if size.height > size.width {
                return .portrait
            } else {
                return .landscape
            }
        }
    }
    
    enum Orientation {
        case portrait
        case landscape
    }
}
