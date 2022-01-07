
import UIKit


class FeaturedViewController: UIViewController{
    
    let eventDataSource = EventDataSource()
    var events : [Event] = []


    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //eventDataSource.writeEvents()
        eventDataSource.delegate = self
        eventDataSource.fetchFeaturedEvents()
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self

      
    }

}

extension FeaturedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You tapped me!")
    }
}

extension FeaturedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventDataSource.getNumberOfFeaturedEvents()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath) as! FeaturedCollectionViewCell
        let realIndex = indexPath.row
        let event = eventDataSource.getFeaturedEventWithIndex(index: realIndex)
        item.featuredImageView.image = UIImage(named: event.imageName)
        return item
    }
}



extension FeaturedViewController: EventDataSourceDelegate{
    
    func eventListLoaded() {
        self.featuredCollectionView.reloadData()
        
    }
    
    func eventDetailLoaded(event: Event) {
        
    }
    
    func categoryEventListLoaded(eventList: [Event]){
        
    }
}


