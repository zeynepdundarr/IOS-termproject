//
//  CollectionViewController.swift
//  EventBrowser
//
//  Created by Zeynep on 7.01.2022.
//

import UIKit



class FilteredEventsCollectionViewController: UICollectionViewController {

    @IBOutlet var filteredEventsCollectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredEventsCollectionView.delegate = self
        filteredEventsCollectionView.dataSource = self

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

   

}

extension FilteredEventsCollectionViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You tapped me!")
    }
}

extension FilteredEventsCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventDataSource.getNumberOfFeaturedEvents()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: filteredCell", for: indexPath) as! FeaturedCollectionViewCell
        let realIndex = indexPath.row
        let event = eventDataSource.getFeaturedEventWithIndex(index: realIndex)
        item.featuredImageView.image = UIImage(named: event.imageName)
        return item
    }
}



