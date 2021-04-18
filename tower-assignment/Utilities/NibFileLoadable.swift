//
//  NibFileLoadable.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import UIKit

protocol NibFileLoadable: UIView {}

extension NibFileLoadable {
    // Instantiate and returns the first view in the Nib
    func instantiateFromNib() -> UIView? {
        let nib = UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        let view = nib.instantiate(withOwner: self, options: nil).filter{$0 is UIView}.first as? UIView
        return view
    }

    // Loads the Nib content (first view) and sets the constraints
    func loadNibContent() {
        guard let view = instantiateFromNib() else {
            fatalError("Failed to instantiate \(String(describing: Self.self)).xib")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
