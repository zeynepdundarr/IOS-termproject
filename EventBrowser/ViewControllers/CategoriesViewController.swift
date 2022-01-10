
import UIKit

class CategoriesViewController: UIViewController {
    
    let eventDataSource = EventDataSource()

    @IBOutlet weak var categoriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! CategoriesTableViewCell
        if let indexPath = self.categoriesTableView.indexPath(for: cell){
            let category = eventDataSource.getCategoryWithIndex(index: getRealIndex(indexPath: indexPath))
            let eventsViewController = segue.destination as! EventsViewController
            eventsViewController.selectedCategory = category
         
        }
    }

    func getRealIndex(indexPath: IndexPath) -> Int {
        let realIndex = indexPath.row.quotientAndRemainder(dividingBy: eventDataSource.getNumberOfCategories()).remainder
        
        return realIndex
    }
    
}

extension CategoriesViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDataSource.getNumberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesTableViewCell
        let category = eventDataSource.getCategoryWithIndex(index: getRealIndex(indexPath: indexPath))
        cell.categoryNameLabel.text = category
        return cell
    }
    
    
}
