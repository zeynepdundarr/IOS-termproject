//
//  CategoryPickerViewController.swift
//  EventBrowser
//
//  Created by Zeynep on 7.01.2022.
//

import UIKit

class CategoryPickerViewController: UIViewController {

    let eventDataSource = EventDataSource()
    var categoriesArray : [String] = []
    var selectedCategory: String = ""
    var categoryEvents : [Event] = []
  
    @IBOutlet weak var filteredEventsCollectionView: UICollectionView!
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        self.title = "Select Category"
        categoriesArray = eventDataSource.getCategoryArray()
        eventDataSource.delegate = self
        
        filteredEventsCollectionView.delegate = self
        filteredEventsCollectionView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let eventsViewController = segue.destination as! EventsViewController
        eventsViewController.selectedCategory = self.selectedCategory
        
        }

}

extension CategoryPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        self.selectedCategory = categoriesArray[row]
        eventDataSource.fetchCategoryEvents(category: self.selectedCategory)
    }
    
}


extension CategoryPickerViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesArray[row]
        
    }
    
}


extension CategoryPickerViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You tapped me!")
    }
}

extension CategoryPickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "filteredEventsCell", for: indexPath) as! FilteredCollectionViewCell
        let realIndex = indexPath.row
     
        let event = self.categoryEvents[realIndex]
        item.filteredEventsCollectionCellImage.image = UIImage(named: event.imageName)
        print("TEST 8 | In collection view category image is: \(UIImage(named: event.imageName))")
      
        return item
    }
}



extension CategoryPickerViewController: EventDataSourceDelegate{
    
    func eventListLoaded() {
    
    }
    
    func eventDetailLoaded(event: Event) {
        
    }
    
    func categoryEventListLoaded(eventList: [Event]){
        self.categoryEvents = eventList
        print("TEST 7 | categoriesPickerView: \(self.categoryEvents)")
        self.filteredEventsCollectionView.reloadData()
    }

}
