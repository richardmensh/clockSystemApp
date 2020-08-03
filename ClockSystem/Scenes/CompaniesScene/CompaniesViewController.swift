//
//  CompaniesViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 29/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//

import UIKit

class CompaniesViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var navigationView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var calendarButton: UIButton!
	@IBOutlet weak var deleteButton: UIButton!
	@IBOutlet weak var companiesCollectionView: UICollectionView!
	@IBOutlet weak var addCompanyView: UIView!
	@IBOutlet weak var addCompanyButton: UIButton!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var emptyDescLabel: UILabel!
	@IBOutlet weak var refreshButton: UIButton!
	var refresher:UIRefreshControl!
	
	
	let presenter: CompaniesPresenter = CompaniesPresenter()
	var canBeRemoved = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter.attachView(view: self)
		view.backgroundColor = .mainBackground
		
		setupLabels()
		setupButtons()
		setupCollectionViews()
		setupViews()
		setupRefreshButton()
		presenter.getCompanies()
		NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .companyAdded, object: nil)
	}
	
}

private extension CompaniesViewController {
	
	func setupRefreshButton() {
		refresher = UIRefreshControl()
		companiesCollectionView.alwaysBounceVertical = true
		refresher.tintColor = .red
		refresher.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
		companiesCollectionView.addSubview(refresher)
	}
	func setupLabels() {
		titleLabel.text = "Companies"
		titleLabel.font = .camptonBold(ofSize: 20)
		titleLabel.textColor = .white
		
		emptyDescLabel.text = "Oeps! there are no data available"
		emptyDescLabel.font = .camptonMedium(ofSize: 15)
		emptyDescLabel.textColor = .white
	}
	
	func setupButtons() {
		calendarButton.setImage(#imageLiteral(resourceName: "ic_calendar").withRenderingMode(.alwaysTemplate), for: .normal)
		calendarButton.tintColor = .white
		calendarButton.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
		
		deleteButton.setImage(#imageLiteral(resourceName: "ic_remove").withRenderingMode(.alwaysTemplate), for: .normal)
		deleteButton.tintColor = .white
		deleteButton.isHidden = true
		
		refreshButton.setTitle("Refresh", for: .normal)
		refreshButton.setTitleColor(.white, for: .normal)
		refreshButton.addTarget(self, action: #selector(refreshPage), for: .touchUpInside)
		
		addCompanyButton.setImage(#imageLiteral(resourceName: "ic_add").withRenderingMode(.alwaysTemplate), for: .normal)
		addCompanyButton.setTitle("", for: .normal)
		addCompanyButton.tintColor = .white
		addCompanyButton.addTarget(self, action: #selector(navigateToAddCompany), for: .touchUpInside)
	}
	
	func setupCollectionViews() {
		companiesCollectionView?.register(CompanyCollectionViewCell.self)
		companiesCollectionView?.delegate = self
		companiesCollectionView?.dataSource = self
		companiesCollectionView.backgroundColor = .clear
	}
	
	func setupViews() {
		emptyView.backgroundColor = .mainBackground
		addCompanyView.backgroundColor = .clear
	}
	
	@objc func navigateToAddCompany() {
		let vc = AddCompanyViewController()
		vc.modalPresentationStyle = .currentContext
		self.present(vc, animated: true, completion: nil)
	}
	
	@objc func calendarButtonPressed() {
		let vc = CalendarViewController()
		vc.modalPresentationStyle = .currentContext
		self.present(vc, animated: true, completion: nil)

	}
	
	@IBAction func deleteButtonPressed(_ sender: Any) {
		canBeRemoved = !canBeRemoved
		companiesCollectionView.reloadData() 
	}
	
	@objc func refreshPage() {
		companiesCollectionView?.refreshControl?.beginRefreshing()
		presenter.getCompanies()
		
	}
	

	
}


