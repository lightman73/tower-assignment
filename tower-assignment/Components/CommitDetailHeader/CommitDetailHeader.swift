//
//  CommitDetailHeader.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import os
import UIKit


@IBDesignable class CommitDetailHeader: UIView, NibFileLoadable {
    // MARK: - Outlets
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var hashTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    // MARK: - Properties
    var commit: Commit? {
        didSet {
            setupView()
        }
    }
    
    // MARK: - Overrided functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        os_log("%{public}@, in %{public}@", log: .ui, type: .debug, #file, #function)
        
        loadNibContent()
        layoutIfNeeded()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        os_log("%{public}@, in %{public}@", log: .ui, type: .debug, #file, #function)
        
        loadNibContent()
        layoutIfNeeded()
        setupView()
    }
    
    
    // MARK: - UI functions
    private func showEmptyView() {
        containerStackView.isHidden = true
    }
    
    private func setupView() {
        guard let commit = commit else {
            showEmptyView()
            return
        }
        
        containerStackView.isHidden = false
        
        authorLabel.text = commit.authorName
        dateLabel.text = commit.date.formattedDate
        hashLabel.text = commit.hash
        
        if let avatar = commit.avatar {
            avatarImageView.image = avatar
        }
    }
}
