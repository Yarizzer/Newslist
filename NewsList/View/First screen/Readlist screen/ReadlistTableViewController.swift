//
//  ReadlistTableViewController.swift
//  NewsList
//
//  Created by Yarr!zzeR on 31/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class ReadlistTableViewController: UITableViewController {

    var viewModel: ReadlistViewModelType?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = ReadlistViewModel()
    }

    private func updateCurrentIndexInModel(forIndexPath indexPath: IndexPath) {
        guard let model = viewModel else { return }
        model.updateCurrentIndex(withIndex: indexPath.row)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! ReadlistTableViewCell

        cell.viewModel = model.getReadlistCellViewModel(withIndex: indexPath.row)
        cell.configureCell()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCurrentIndexInModel(forIndexPath: indexPath)
        performSegue(withIdentifier: Constants.readlistDetailSegue, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        updateCurrentIndexInModel(forIndexPath: indexPath)
        let addToReadListAction = UITableViewRowAction(style: .normal, title: NSLocalizedString("Remove from list", comment: "Remove from list")) { [unowned self] (action, indexPath) in
            guard let model = self.viewModel else { return }
            model.removeReadList()
            tableView.deleteRows(at: [indexPath], with: .right)
        }
        
        addToReadListAction.backgroundColor = #colorLiteral(red: 0, green: 0.9938529134, blue: 1, alpha: 1)
        return [addToReadListAction]
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let model = viewModel else { return }
        if segue.identifier == Constants.readlistDetailSegue {
            let dvc = segue.destination as! DetailViewController
            dvc.viewModel = model.getDetailScreenViewModel()
        }
    }

}

extension ReadlistTableViewController {
    private struct Constants {
        static let cellID = "readlistCell"
        static let readlistDetailSegue = "showReadlistDetail"
        
    }
}



