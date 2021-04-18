//
//  MainVC.swift
//  tower-assignment
//
//  Created by Francesco Marini on 18/04/21.
//

import Foundation
import UIKit

fileprivate struct Constants {
    static let tableViewCellsHeight: CGFloat  = 90.0
    static let tableViewBottomPadding: CGFloat  = 60.0
}


class MainVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var commitsTableView: UITableView!
    
    
    // MARK: - Properties
    var APIService: APIService?
    
    weak var detailVC: DetailVC?
    
    var commits: [Commit] = []
    
    
    // MARK: - Overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        reloadData()
    }
    
    
    // MARK: - UI functions
    private func setupTableView() {
        commitsTableView.delegate = self
        commitsTableView.dataSource = self
        commitsTableView.estimatedRowHeight = Constants.tableViewCellsHeight
        commitsTableView.rowHeight = UITableView.automaticDimension
        commitsTableView.contentInset.bottom = commitsTableView.contentInset.bottom + Constants.tableViewBottomPadding
        commitsTableView.register(CommitCell.nib, forCellReuseIdentifier: CommitCell.identifier)
    }
    
    
    // MARK: - Custom functions
    private func reloadData() {
        APIService?.getCommitsList { result in
            switch result {
            case .success(let commits):
                self.commits = commits
                DispatchQueue.main.async {
                    self.commitsTableView.reloadData()
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
    
    
    // MARK: - Actions
    private func didTapOn(commit: Commit) {
        detailVC?.commit = commit
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailVC {
            self.detailVC = detailVC
            detailVC.APIService = APIService
        }
    }
}


// MARK: - Extensions
// Note: This might be extracted to separate MainVC+UITableViewDataSource and MainVC+UITableViewDelegate
//       but since the viewcontroller is really small, it makes sense to keep them here

// MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommitCell.identifier, for: indexPath) as! CommitCell
        
        cell.commit = commits[index]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
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
        
        didTapOn(commit: commits[indexPath.row])
        return
    }
}
