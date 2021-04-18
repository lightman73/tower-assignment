//
//  CommitCell.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import os
import UIKit

class CommitCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    
    // MARK: - Properties
    var commit: Commit? {
        didSet {
            setupView()
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Overrided functions
    override func prepareForReuse() {
        super.prepareForReuse()
      
        avatarImageView.image = UIImage(systemName: "person.fill")
        authorNameLabel.text = nil
        dateLabel.text = nil
        hashLabel.text = nil
        subjectLabel.text = nil
    }
    
    
    // MARK: - UI functions
    private func setupView() {
        guard let commit = commit else {
            return
        }
        
        authorNameLabel.text = commit.authorName
        dateLabel.text = commit.date.formattedShortDate
        hashLabel.text = commit.hash
        subjectLabel.text = commit.subject
        
        if let avatar = commit.avatar {
            avatarImageView.image = avatar
        } else {
            avatarImageView.image = UIImage(systemName: "person.fill")
        }
    }
}
