//
//  NewsListTableViewController.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {

    var viewModel: NewsListViewModelType?
    var shouldUpdateTableView: Bool? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = NewsListViewModel()
        guard let model = viewModel else { return }
        model.shouldUpdateView.bind {
            guard let value = $0 else { return }
            self.shouldUpdateTableView = value
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search news"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction func readlistAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.readlistSegueIdentifier, sender: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel else { return 0 }
        return model.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsListCell", for: indexPath) as! NewsListCellTableViewCell
        cell.viewModel = model.getNewsListCellViewModel(withIndex: indexPath.row)
        cell.configureCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel else { return }
        model.setCurrentIndex(withValue: indexPath.row)
        model.setWatchedMark()
        performSegue(withIdentifier: Constants.detailScreenSegueIdentifier, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let addToReadListAction = UITableViewRowAction(style: .normal, title: NSLocalizedString("Add to read list", comment: "Add to read list")) { [unowned self] (action, indexPath) in
            guard let model = self.viewModel else { return }
            model.addAtricleToReadList(withIndex: indexPath.row)
        }
        
        addToReadListAction.backgroundColor = #colorLiteral(red: 0, green: 0.9938529134, blue: 1, alpha: 1)
        return [addToReadListAction]
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let model = viewModel else { return }
        if segue.identifier == Constants.detailScreenSegueIdentifier {
            let dvc = segue.destination as! DetailViewController
            dvc.transitioningDelegate = self
            dvc.viewModel = model.getDetailScreenViewModel()
        } else if segue.identifier == Constants.readlistSegueIdentifier {
            let dvc = segue.destination as! ReadlistTableViewController
            dvc.viewModel = model.getReadlistViewModel()
            dvc.modalPresentationStyle = .popover
            let popOverVC = dvc.popoverPresentationController
            popOverVC?.delegate = self
        }
    }
}

//Search Delegate
extension NewsListTableViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let model = viewModel else { return }
        let searchText = searchController.searchBar.text!
        model.setUserIsSearching(with: isFiltering())
        model.searchNews(withText: searchText)
        tableView.reloadData()
    }
}

//Popover Presentation delegate
extension NewsListTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//Custom transitioning
extension NewsListTableViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(isPresenting: false)
    }
}

extension NewsListTableViewController {
    private struct Constants {
        static let detailScreenSegueIdentifier = "showDetail"
        static let readlistSegueIdentifier = "showReadlist"
    }
}



