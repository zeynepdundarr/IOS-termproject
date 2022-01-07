

import UIKit

class EventsViewController: UIViewController {
    
    let eventDataSource = EventDataSource()
    var selectedCategory: String?
    var categoryEvents : [Event] = []

    @IBOutlet weak var eventsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCategory!+"s"
        eventDataSource.delegate = self
        // Do any additional setup after loading the view.
        eventDataSource.fetchCategoryEvents(category: self.selectedCategory!)
    }
   
    func getRealIndex(indexPath: IndexPath) -> Int {
        let realIndex = indexPath.row
        return realIndex
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
       let cell = sender as! EventsTableViewCell
       if let indexPath = self.eventsTableView.indexPath(for: cell){
           let event = eventDataSource.getCategoryEventsWithIndex(index: getRealIndex(indexPath: indexPath), category: self.selectedCategory!)
           let eventDetailViewController = segue.destination as! EventDetailViewController
           eventDetailViewController.selectedEventName = event.name
       }
   }

}



extension EventsViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDataSource.getNumberOfCategoryEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as! EventsTableViewCell
        let event = eventDataSource.getCategoryEventsWithIndex(index: getRealIndex(indexPath: indexPath), category: self.selectedCategory!)
        cell.eventNameLabel.text = event.name
        return cell
    }
}


extension EventsViewController: EventDataSourceDelegate{
    
    func eventListLoaded() {
    
    }
    
    func eventDetailLoaded(event: Event) {
        
    }
    
    func categoryEventListLoaded(eventList: [Event]){
        self.categoryEvents = eventDataSource.getCategoryEvents()
        self.eventsTableView.reloadData()

    
    }

}
