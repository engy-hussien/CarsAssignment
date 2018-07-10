//
//  HomeViewController.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PullToRefreshKit


protocol HomeViewProtocol: NSObjectProtocol {
    func startAnimating()
    func stopAnimating()
    func setupViewWith(list: [CarModel])
    func setupForError(error: String)
}

class HomeViewController: UIViewController {

    //MARK-: view outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var screenTitleLabel: UILabel!
    @IBOutlet weak var kFilterLabel: UILabel!
    @IBOutlet weak var kSortLabel: UILabel!
    @IBOutlet weak var kGridViewLabel: UILabel!
    @IBOutlet weak var tableViewTitleLabel: UILabel!
    
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    
    //MARK-: view actions
    
    @IBAction func sortBtnTouchUpInside(_ sender: UIButton) {
    }
    
    //MARK-: view properties
    var presenter: HomePresenter?
    let viewCornerRadius : CGFloat = 8.0
    let estimatedRowHeight : CGFloat = 100.0
    var contentOffSet : CGFloat = 0.0
    var errorText = ""
    var carsList = [CarModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK-: view load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(withView: self)
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
        self.localizeView()
    }
    
    
    //MARK-: view setup
    func setupView() {
        self.topView.layer.cornerRadius =  viewCornerRadius
    }
    
    func localizeView() {
        self.screenTitleLabel.text = "cars.title.label".localizedString
        self.kFilterLabel.text = "filter.label".localizedString
        self.kSortLabel.text = "sort.label".localizedString
        self.kGridViewLabel.text = "grid.view.label".localizedString
        self.tableViewTitleLabel.text = "search.label".localizedString
    }
    
    func configureTableView() {
        self.tableView.estimatedRowHeight = self.estimatedRowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableHeaderView = tableHeaderView
        self.tableView.register(UINib(nibName: kCarCell , bundle: nil),
                                forCellReuseIdentifier: kCarCellID)
        self.tableView?.register(UINib(nibName: kErrorCell , bundle: nil),
                                 forCellReuseIdentifier: kErrorCellID)
        self.tableView.configRefreshHeader(container:self) { [weak self] in
            self?.presenter?.getListUpdates()
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard carsList.isEmpty else {
            return carsList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !carsList.isEmpty else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kErrorCellID, for: indexPath)  as! ErrorTableViewCell
            cell.title.text = self.errorText
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: kCarCellID, for: indexPath) as! CarTableViewCell
        cell.setupCellFor(car: carsList[indexPath.row])
        return cell
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func startAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), nil)
    }
    
    func stopAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    func setupViewWith(list: [CarModel]) {
        self.carsList += list
        self.errorText = self.carsList.isEmpty ? "error".localizedString : ""
        self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
    }
    
    func setupForError(error: String) {
        self.errorText = error
        self.carsList.removeAll()
        self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
    }
}
