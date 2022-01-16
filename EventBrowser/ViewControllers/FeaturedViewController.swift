
import UIKit
import FirebaseStorage


class FeaturedViewController: UIViewController{
    
    let eventDataSource = EventDataSource()
    var events : [Event] = []
    var selectedEvent: Event?


    @IBOutlet weak var featuredCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileReadandWrite = FileReadandWrite(path: "abc", fileName: "bcd")
        fileReadandWrite.downloadImage()
        // write images to firestore
        
        //eventDataSource.writeEvents()
        eventDataSource.delegate = self
        eventDataSource.fetchFeaturedEvents()
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let cell = sender as! FeaturedCollectionViewCell
            if let indexPath = self.featuredCollectionView.indexPath(for: cell) {
                let event = eventDataSource.getFeaturedEventWithIndex(index: getRealIndex(indexPath: indexPath))
                    let eventDetailViewController = segue.destination as! EventDetailViewController
                    self.selectedEvent = event
                    eventDetailViewController.selectedEventName = self.selectedEvent!.name
                }
        }else{
            print("Picker segue in!")
        }
            
        }
    
    func getRealIndex(indexPath: IndexPath) -> Int {
        if (eventDataSource.getNumberOfFeaturedEvents() == 0) {
            return 0;
        }
        let realIndex = indexPath.row
        return realIndex
    }
    
    func writeImagesToFirestore(imagePath: String){
        
        let storageRef = Storage.storage().reference()

        // File located on disk
        let localFile = URL(string: "path/to/image")!

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/rivers.jpg")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
            
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


