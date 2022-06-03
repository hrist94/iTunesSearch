//
//  CustomButton.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 02.06.2022.
//

import UIKit


class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            guard let color = backgroundColor else { return }

            layer.removeAllAnimations()
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.allowUserInteraction], animations: {
                self.backgroundColor = color.withAlphaComponent(self.isHighlighted ? 0.3 : 1)
            })
        }
    }
}
