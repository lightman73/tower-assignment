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
    @IBOutlet weak var diffContainer: UIStackView!
    

    // MARK: - Properties
    var changeset: ChangesetEntry? {
        didSet {
            setupView()
        }
    }
    
    var diffText: String? {
        didSet {
            if diffText != nil {
                diffLabel.text = diffText
            } else {
                diffLabel.text = "Diff not yet loaded"
            }
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
        expandImageView.image = nil
        diffLabel.text = nil
        diffContainer.isHidden = true
        diffViewStatus = .reduced
    }
    
    
    // MARK: - UI functions
    private func setupView() {
        guard let changeset = changeset else {
            return
        }
        
        statusLabel.text = changeset.status.rawValue
        filenameLabel.text = changeset.filename
        expandImageView.image = UIImage(systemName: "arrowtriangle.right.fill")
        diffContainer.isHidden = true
        diffViewStatus = .reduced
    }
    
    private func showOrHideDiff() {
        switch diffViewStatus {
        case .reduced:
            showDiff()
        case .expanded:
            hideDiff()
        }
    }
    
    public func showDiff() {
        expandImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        diffContainer.isHidden = false
        diffViewStatus = .expanded
        layoutIfNeeded()
    }
    
    public func hideDiff() {
        expandImageView.image = UIImage(systemName: "arrowtriangle.right.fill")
        diffContainer.isHidden = true
        diffViewStatus = .reduced
        layoutIfNeeded()
    }
}
