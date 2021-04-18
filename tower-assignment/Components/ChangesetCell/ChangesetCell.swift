//
//  ChangesetCell.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import os
import UIKit


enum DiffViewStatus {
    case reduced
    case expanded
}

fileprivate struct Constants {
    static let expandAnimationDuration = 0.3
    static let hideAnimationDuration = 0.2
}


class ChangesetCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var filenameLabel: UILabel!
    @IBOutlet weak var expandImageView: UIImageView!
    @IBOutlet weak var diffLabel: UILabel!
    

    // MARK: - Properties
    var changeset: ChangesetEntry? {
        didSet {
            setupView()
        }
    }
    
    var diffText: String? {
        didSet {
            diffLabel.text = diffText
        }
    }
    
    var diffViewStatus: DiffViewStatus = .reduced
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Overrided functions
    override func prepareForReuse() {
        super.prepareForReuse()
      
        statusLabel.text = nil
        filenameLabel.text = nil
        diffLabel.text = nil
        expandImageView.image = nil
        diffViewStatus = .reduced
    }
    
    
    // MARK: - UI functions
    private func setupView() {
        guard let changeset = changeset else {
            return
        }
        
        expandImageView.image = UIImage(systemName: "arrowtriangle.right.fill")
        
        statusLabel.text = changeset.status.rawValue
        filenameLabel.text = changeset.filename
    }
    
    
    // MARK: - IBActions
    
    @IBAction func didTapExpandView(_ sender: Any) {
        switch diffViewStatus {
        case .reduced:
            expandImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            UIView.animate(withDuration: Constants.expandAnimationDuration) {
                self.diffLabel.isHidden = false
            }
            diffViewStatus = .expanded
        case .expanded:
            expandImageView.image = UIImage(systemName: "arrowtriangle.right.fill")
            UIView.animate(withDuration: Constants.hideAnimationDuration) {
                self.diffLabel.isHidden = true
            }
            diffViewStatus = .reduced
        }
    }
}
