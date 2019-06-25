//
//  EventDetailViewController.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import Foundation
import UIKit

public struct TableConstants {
    static let imageOffset: CGFloat = -64.0
    static let imageHeight: CGFloat = 300.0
    static let imageStretchFactor: CGFloat = 400.0
    static let estimatedRowHeight: CGFloat = 240.0
    static let minImageHeight: CGFloat = 60.0
}

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoHeader: UIView!
    @IBOutlet weak var infoLabel: UILabel!
   
    var event: Event?
    var headerImage: UIImage?
    let headerView = DetailHeaderView.create()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.updateNavbarAppearence(isClear: true)
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        navigationItem.rightBarButtonItem = shareButton
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets.init(top: TableConstants.imageHeight, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = TableConstants.estimatedRowHeight
        
        headerView.image = headerImage
        headerView.frame = CGRect(x: 0, y: 0.0, width: UIScreen.main.bounds.size.width, height: TableConstants.imageHeight)
        
        view.addSubview(headerView)
        infoLabel.text = event?.title
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func share(sender: UIBarButtonItem) {
        
        // Pretty formatting
        let date = event?.formattedDate() ?? "" + "\n"
        let title = event?.title ?? "" + "\n"
        let loc1 = event?.loc1 ?? "" + "\n"
        let loc2 = event?.loc2 ?? "" + "\n"
        let desc = event?.desc ?? "" + "\n"
        let info: [String] = [date, title, loc1, loc2, desc]
        
        let activityViewController = UIActivityViewController(activityItems: info, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ .airDrop, .postToFacebook, .print ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    public class func create(with event: Event, image: UIImage?) -> EventDetailViewController? {
        let bundle = Bundle(for: EventDetailViewController.self)
        guard let vc = UIStoryboard(name: "Main", bundle: bundle).instantiateViewController(withIdentifier: "detailVC") as? EventDetailViewController else { return nil }
        
        vc.event = event
        vc.headerImage = image
        return vc
    }
}

extension EventDetailViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseId()) as? DescriptionCell else { return UITableViewCell() }
        guard let event = event else { return UITableViewCell() }
        
        cell.update(with: event)
        return cell
    }
}

extension EventDetailViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableConstants.estimatedRowHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = TableConstants.imageHeight - (scrollView.contentOffset.y + TableConstants.imageHeight)
        let height = min(max(y, TableConstants.minImageHeight), TableConstants.imageStretchFactor)
        
        headerView.frame = CGRect(x: 0, y: TableConstants.imageOffset, width: UIScreen.main.bounds.size.width, height: height)
    }
}
