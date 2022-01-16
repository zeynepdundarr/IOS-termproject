//
//  EventDetailViewController.swift
//  EventBrowser
//
//  Created by Zeynep on 20.12.2021.
//

import UIKit

class EventDetailViewController: UIViewController{

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var eventDataSource = EventDataSource()
    var selectedEventName: String?
    var event : Event?
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDataSource.delegate = self
        eventName.text = selectedEventName
        eventDataSource.fetchAnEvent(name: selectedEventName!)
      
//        let index = 2 //0 to 5
//        viewControllers?.remove(at: index)

        
    }
    

  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension  EventDetailViewController: EventDataSourceDelegate {
    
    func eventListLoaded() {
        
    }
    
    func eventDetailLoaded(event: Event) {
        eventImage.image = UIImage(named: event.imageName )
        //write other details
        category.text = event.category
        date.text = event.date
        place.text = event.place
        price.text = String(event.price)
    
    }
    
    func categoryEventListLoaded(eventList: [Event]) {
        
    }
    

}
