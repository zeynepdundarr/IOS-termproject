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
    
    var eventDataSource = EventDataSource()
    var selectedEventName: String?
    var event : Event?
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDataSource.delegate = self
        eventName.text = selectedEventName
        // print("TEST 27 | Selected category event is in event detail \(selectedEventName)")
        // Do any additional setup after loading the view.
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
        self.eventName.text = event.name
        
    }
    
    func categoryEventListLoaded(eventList: [Event]) {
        
    }
    

}
