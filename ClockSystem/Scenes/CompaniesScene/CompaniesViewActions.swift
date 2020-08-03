//
//  CompaniesViewActions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 29/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

extension CompaniesViewController {
	@objc func onDidReceiveData(_ notification: Notification) {
		if let data = notification.userInfo as? [String: Any] {
			_ = data.map {
				guard let canObtainData = $0.value as? Bool else { return }
				if canObtainData {
					presenter.getCompanies()
				}
			}
		}
	}
}

extension CompaniesViewController: UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.companies.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: CompanyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
		let company = presenter.companies[indexPath.row]
		cell.config(company: company, remove: canBeRemoved)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if canBeRemoved {
			let company = presenter.companies[indexPath.row]
			presenter.companyId = company.id
			presenter.deleteCompany(id: company.id)
		} else {
			let company = presenter.companies[indexPath.row]
			let vc = ClockViewController()
			vc.company = company
			vc.modalPresentationStyle = .currentContext
			self.present(vc, animated: true, completion: nil)
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let height = view.frame.height * 0.2
		let width = (view.frame.width / 2) - 10
		return CGSize(width: width, height: height)
	}
	
}

extension CompaniesViewController: CompaniesPresenterProtocol {
	func obtainCompanies() {
		// Delete all event created for this company
		let id: String = presenter.companyId
		if !presenter.eventsDeleted {
			print("obtain true")
			presenter.events.forEach { event in
				if event.companyId == id {
					presenter.deleteEvent(id: event.id)
				}
			}
			eventsDeleted()
		}
		if !presenter.companies.isEmpty {
			deleteButton.isHidden = false
			emptyView.isHidden = true
		} else {
			deleteButton.isHidden = true
			emptyView.isHidden = false
		}
		DispatchQueue.main.async {
			self.companiesCollectionView.reloadData()
			self.refresher.endRefreshing()
			
		}
	}
	
	func eventsDeleted() {
		presenter.eventsDeleted = true
		canBeRemoved = !canBeRemoved
		companiesCollectionView.reloadData()
		
	}
	
}
