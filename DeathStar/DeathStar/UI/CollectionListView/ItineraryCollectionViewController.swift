//
//  ItineraryCollectionViewController.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/30/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import UIKit

class ItineraryCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var events: [Event]?
    private var currentEvent: Event?
    private var currentFrame : CGRect?
    private var currentImage: UIImage?
    
    private let listLayout = ListLayout()
    private let gridLayout = GridLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
       
        collectionView.register(UINib(nibName: "EventCollectionCell", bundle:nil), forCellWithReuseIdentifier: EventCollectionCell.reuseId())
        collectionView.delegate = self
        collectionView.dataSource = self
        configureLayoutForSize()
        
        fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Star Wars Calendar"
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        configureLayoutForSize()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let vc = segue.destination as? EventDetailViewController else { return }
        vc.event = currentEvent
        vc.headerImage = currentImage
        
        // Remove unsightly back button title
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    private func configureLayoutForSize() {
        var layout: UICollectionViewLayout = listLayout
        let vertTrait = traitCollection.verticalSizeClass
        let horoTrait = traitCollection.horizontalSizeClass
       
        // only iPad should get the grid layout, even tho it looks pretty ok in plus iPhone sizes
        if vertTrait == .regular && horoTrait == .regular {
            layout = gridLayout
        }
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension ItineraryCollectionViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.reuseId(), for: indexPath) as? EventCollectionCell else { return UICollectionViewCell() }
        guard let event = events?[indexPath.row] else { return UICollectionViewCell() }
        
        cell.update(event: event)
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ItineraryCollectionViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let attribs: UICollectionViewLayoutAttributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        
        let frame: CGRect  = collectionView.convert(attribs.frame, to: collectionView.superview)
        currentFrame = frame
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventCollectionCell else { return }
        currentImage = cell.backgroundImageView.image
        
        currentEvent = events?[indexPath.row]
        self.performSegue(withIdentifier: "detailSegues", sender: nil)
    }
}

// Fetch the data from the view model controller
extension ItineraryCollectionViewController {
    fileprivate func fetch() {
        let url = URL(string: APIConstants.jsonFeedEndpoint)
        EventService.fetchEvents(url: url, completion: { (success, events, error) in
            guard success else { return }
            self.events = events
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

// Sets custom push and pop animations for the nav controller
extension ItineraryCollectionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            let frame = UIScreen.main.bounds
            guard let image = currentImage else { return nil }
            return DetailPresentAnimator(originFrame: frame, image: image)
        } else {
            return DetailPopAnimator()
        }
    }
}
