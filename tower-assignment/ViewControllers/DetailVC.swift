//
//  DetailVC.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation
import UIKit

fileprivate struct Constants {
    static let tableViewCellsHeight: CGFloat  = 60.0
    static let tableViewBottomPadding: CGFloat  = 60.0
}


class DetailVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var headerView: CommitDetailHeader!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var changesetsTableView: UITableView!

    
    // MARK: - Properties
    var APIService: APIService?
    
    var commit: Commit? {
        didSet {
            if commit != nil {
                headerView.commit = commit
                subjectLabel.text = commit?.subject
                changeset = []
                changesetsTableView.reloadData()
                hideEmptyView()
                reloadData()
            } else {
                showEmptyView()
            }
        }
    }
    
    var changeset: [ChangesetEntry] = []
    var diffs: [String] = []
    
    var expandedCellsIndexSet : IndexSet = []
    
    var emptyView: UIView?
    
    
    // MARK: - Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
     
        showEmptyView()
        setupTableView()
    }
    
    
    // MARK: - UI functions
    private func setupTableView() {
        changesetsTableView.delegate = self
        changesetsTableView.dataSource = self
        changesetsTableView.delaysContentTouches = false
        changesetsTableView.separatorInset = .zero
        changesetsTableView.layoutMargins = .zero
//        changesetsTableView.estimatedRowHeight = Constants.tableViewCellsHeight
        changesetsTableView.rowHeight = UITableView.automaticDimension
        changesetsTableView.contentInset.bottom = changesetsTableView.contentInset.bottom + Constants.tableViewBottomPadding
        changesetsTableView.register(ChangesetCell.nib, forCellReuseIdentifier: ChangesetCell.identifier)
    }
    
    
    func showEmptyView() {
        emptyView = UIView(frame: self.view.bounds)
        
        guard let emptyView = emptyView else {
            return
        }
        
        emptyView.backgroundColor = .white
        self.view.addSubview(emptyView)
    }
    
    func hideEmptyView() {
        guard let view = emptyView else {
            return
        }
        
        view.removeFromSuperview()
        emptyView = nil
    }
    
    
    // MARK: - Custom functions
    func reloadData() {
        guard let commit = commit else {
            return
        }
        
        APIService?.getChangesetFrom(commitHash: commit.hash) { result in
            switch result {
            case .success(let changesets):
                self.changeset = changesets
                self.prefetchDiffs()
                DispatchQueue.main.async {
                    self.changesetsTableView.reloadData()
                }
            case .failure(let error):
                // TODO: Should add better error handling
                switch error {
                case .dataConversionError, .missingData, .serverError(_, _, _):
                    self.showAlert(title: "Error", message: "Could not load data")
                    break
                }
            }
        }
    }
    
    func prefetchDiffs() {
        guard let commit = commit else {
            return
        }
        
        diffs = Array(repeating: "", count: changeset.count)
        
        if changeset.count == 0 {
            return
        }
        
        for (index, entry) in changeset.enumerated() {
            APIService?.getDiffFor(commitHash: commit.hash, filename: entry.filename) { result in
                switch result {
                case .success(let diff):
                    self.diffs[index] = diff ?? ""
                case .failure(let error):
                    // TODO: Should add better error handling
                    switch error {
                    case .dataConversionError, .missingData, .serverError(_, _, _):
                        self.showAlert(title: "Error", message: "Could not load diff for \(entry.filename)")
                        break
                    }
                }
            }
        }
    }
}


// MARK: - Extensions

// MARK: - UITableViewDataSource
extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changeset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangesetCell.identifier, for: indexPath) as! ChangesetCell
        
        cell.layoutMargins = .zero
        
        cell.changeset = changeset[index]
        cell.diffText = diffs[index]
        
        if expandedCellsIndexSet.contains(indexPath.row) {
            cell.showDiff()
        } else {
            cell.hideDiff()
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if(expandedCellsIndexSet.contains(indexPath.row)){
            expandedCellsIndexSet.remove(indexPath.row)
        } else {
            expandedCellsIndexSet.insert(indexPath.row)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        return
    }
}
