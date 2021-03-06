import Foundation
import UIKit
import grpc
import Firebase


class EventDataSource: ObservableObject {


    @Published var events = [Event]()
    var featuredEvents : [Event] = []
    var categoryEvents : [Event] = []
    private var eventArray: [Event] = []
    
    var event : [Event] = []
    let db = Firestore.firestore()
    var delegate: EventDataSourceDelegate?
    
    //recreate categories array by obtaining it from the array from database
    private var categoryArray = ["Concert", "Workshop", "Theater"]
  
    
    // Category events
    func getCategoryEventsWithIndex(index: Int, category: String) -> Event {
        return self.categoryEvents[index]
    }

    func getNumberOfCategoryEvents() -> Int {
        return categoryEvents.count
    }
    
    // categories
    func getNumberOfCategories() -> Int {
        return categoryArray.count
    }
    
    func getCategoryWithIndex(index: Int) -> String {
        return categoryArray[index]
    }
    
    func getCategoryEvents() -> [Event]{
        return self.categoryEvents
    }
    
    //featured events
    func getFeaturedEvents() -> [Event]{

        return self.featuredEvents
    }
    
    func getNumberOfFeaturedEvents() -> Int {
        return self.featuredEvents.count
    }
    
    func getFeaturedEventWithIndex(index: Int) -> Event {
        return self.featuredEvents[index]
    }
    
    func getCategoryArray() -> [String]{
        return self.categoryArray
    }
    
    func fetchData(){
        print("TEST 4 | All data is fetching")
        db.collection("events").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
        self.events = documents.compactMap { queryDocumentSnapshot -> Event in
          let data = queryDocumentSnapshot.data()
          let name = data["name"] as? String ?? ""
          let category = data["category"] as? String ?? ""
          let date = data["date"] as? String ?? ""
          let place = data["place"] as? String ?? ""
          let price = data["price"] as? Int ?? 0
          let imageName = data["imageName"] as? String ?? ""
          let isFeatured = data["isFeatured"] as? Bool ?? true
            
          return Event(id: .init(), name: name, category: category, date: date, place: place,  price:  price, imageName: imageName, isFeatured: isFeatured)
      }
         self.delegate?.eventListLoaded()
        }
    }
    
    func fetchFeaturedEvents(){
       
        let eventsRef = db.collection("events")
        eventsRef.whereField("isFeatured", isEqualTo: true).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.featuredEvents = querySnapshot!.documents.compactMap { queryDocumentSnapshot -> Event in
                      let data = queryDocumentSnapshot.data()
                      let name = data["name"] as? String ?? ""
                      let category = data["category"] as? String ?? ""
                      let date = data["date"] as? String ?? ""
                      let place = data["place"] as? String ?? ""
                      let price = data["price"] as? Int ?? 0
                      let imageName = data["imageName"] as? String ?? ""
                      let isFeatured = data["isFeatured"] as? Bool ?? true
                        
                        return Event(id: .init(), name: name, category: category, date: date, place: place,  price:  price, imageName: imageName, isFeatured: isFeatured)
                  }
                    self.delegate?.eventListLoaded()
    
                }
        }
    }
    
    func fetchCategoryEvents(category: String){
        print("TEST 5 | Category data is fetching")
        let eventsRef = db.collection("events")
        eventsRef.whereField("category", isEqualTo: category).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.categoryEvents = querySnapshot!.documents.compactMap { queryDocumentSnapshot -> Event in
                      let data = queryDocumentSnapshot.data()
                      let name = data["name"] as? String ?? ""
                      let category = data["category"] as? String ?? ""
                      let date = data["date"] as? String ?? ""
                      let place = data["place"] as? String ?? ""
                      let price = data["price"] as? Int ?? 0
                      let imageName = data["imageName"] as? String ?? ""
                      let isFeatured = data["isFeatured"] as? Bool ?? true
                        return Event(id: .init(), name: name, category: category, date: date, place: place,  price:  price, imageName: imageName, isFeatured: isFeatured)
                  }
                    self.delegate?.categoryEventListLoaded(eventList: self.categoryEvents)
                }
        }
    }
    
    func fetchAnEvent(id: String){

        let eventsRef = db.collection("events")
        eventsRef.whereField("id", isEqualTo: id).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.event = querySnapshot!.documents.compactMap { queryDocumentSnapshot -> Event in
                      let data = queryDocumentSnapshot.data()
                      let name = data["name"] as? String ?? ""
                      let category = data["category"] as? String ?? ""
                      let date = data["date"] as? String ?? ""
                      let place = data["place"] as? String ?? ""
                      let price = data["price"] as? Int ?? 0
                      let imageName = data["imageName"] as? String ?? ""
                      let isFeatured = data["isFeatured"] as? Bool ?? true
                      return Event(id: .init(), name: name, category: category, date: date, place: place,  price:  price, imageName: imageName, isFeatured: isFeatured)
                  }
                   
                    self.delegate?.eventDetailLoaded(event: self.event[0])
                }
        }
    }

    func writeEvents(){
        //concerts

        var ref: DocumentReference? = nil
                ref = db.collection("events").addDocument(data: [
                    "name": "Serdar Orta??",
                    "category": "Concert",
                    "date": "9 January 2022, 21.00",
                    "place" : "K??????k??iftlik Park, ??stanbul",
                    "price": 250,
                    "imageName": "1",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Mabel Matiz",
                    "category": "Concert",
                    "date": "31 December 2021, 21.00",
                    "place" : "K??????k??iftlik Park, ??stanbul",
                    "price": 350,
                    "imageName": "2",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Ya??ar",
                    "category": "Concert",
                    "date": "11 January 2022, 21.00",
                    "place" : "K??????k??iftlik Park, ??stanbul",
                    "price": 300,
                    "imageName": "3",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }


                ref = db.collection("events").addDocument(data: [
                    "name": "G??l??en",
                    "category": "Concert",
                    "date": "12 January 2022, 21.00",
                    "place" : "K??????k??iftlik Park, ??stanbul",
                    "price": 250,
                    "imageName": "4",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Hey! Douglas",
                    "category": "Concert",
                    "date": "14 January 2022, 21.00",
                    "place" : "K??????k??iftlik Park, ??stanbul",
                    "price": 200,
                    "imageName": "5",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }


        //movies

                ref = db.collection("events").addDocument(data: [
                    "name": "Spider-man: No Way Home",
                    "category": "Movie",
                    "date": "17 December 2021, 12.15",
                    "place" : "Cinemaximum Palladium, ??stanbul",
                    "price": 40,
                    "imageName": "6",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "The Matrix: Resurrections",
                    "category": "Movie",
                    "date": "27 December 2021, 12.00",
                    "place" : "Cinemaximum ??stinyePark, ??stanbul",
                    "price": 40,
                    "imageName": "7",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Day??: Bir Adam??n Hikayesi",
                    "category": "Movie",
                    "date": "14 December 2021, 09.00",
                    "place" : "Cinemaximum Kanyon, ??stanbul",
                    "price": 40,
                    "imageName": "8",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }


                ref = db.collection("events").addDocument(data: [
                    "name": "Aykut Eni??te 2",
                    "category": "Movie",
                    "date": "1 January 2022, 12.15",
                    "place" : "Cinemaximum Palladium, ??stanbul",
                    "price": 40,
                    "imageName": "9",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }


                ref = db.collection("events").addDocument(data: [
                    "name": "No Time To Die",
                    "category": "Movie",
                    "date": "2 January 2022, 12.15",
                    "place" : "Cinemaximum ??stinyePark, ??stanbul",
                    "price": 40,
                    "imageName": "10",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

        //Theater

                ref = db.collection("events").addDocument(data: [
                    "name": "Cimri",
                    "category": "Theater",
                    "date": "18 December 2021, 14.00",
                    "place" : "Haldun Taner Sahnesi, ??stanbul",
                    "price": 30,
                    "imageName": "11",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Bir Delinin Hat??ra Defteri",
                    "category": "Theater",
                    "date": "12 January 2022, 12.00",
                    "place" : "Fi??ekhane Ana Sahne, ??stanbul",
                    "price": 30,
                    "imageName": "12",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Mah??er-i C??mb????",
                    "category": "Theater",
                    "date": "1 January 2022, 14.00",
                    "place" : "Trump Sahne, ??stanbul",
                    "price": 30,
                    "imageName": "13",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "A??a??lar Ayakta ??l??r",
                    "category": "Theater",
                    "date": "2 January 2022, 11.00",
                    "place" : "Kad??k??y Hakl E.M., ??stanbul",
                    "price": 30,
                    "imageName": "14",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Memleketimden ??nsan Manzaralar??",
                    "category": "Theater",
                    "date": "5 January 2022, 14.00",
                    "place" : "Caddebostan K??lt??r Merkezi, ??stanbul",
                    "price": 30,
                    "imageName": "15",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }


        //Workshops

                ref = db.collection("events").addDocument(data: [
                    "name": "Pastac??l??k",
                    "category": "Workshop",
                    "date": "3 January 2022, 11.00",
                    "place" : "Mutfak Sanatlar?? Akademisi, ??stanbul",
                    "price": 300,
                    "imageName": "16",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Kahve",
                    "category": "Workshop",
                    "date": "5 January 2022, 12.00",
                    "place" : "Mutfak Sanatlar?? Akademisi, ??stanbul",
                    "price": 150,
                    "imageName": "11",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "D??nya Mutfaklar??",
                    "category": "Workshop",
                    "date": "5 January 2022, 10.00",
                    "place" : "Mutfak Sanatlar?? Akademisi, ??stanbul",
                    "price": 400,
                    "imageName": "18",
                    "isFeatured": true
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "??ikolata ve Dondurma",
                    "category": "Workshop",
                    "date": "7 January 2022, 11.00",
                    "place" : "Mutfak Sanatlar?? Akademisi, ??stanbul",
                    "price": 200,
                    "imageName": "19",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }

                ref = db.collection("events").addDocument(data: [
                    "name": "Etler",
                    "category": "Workshop",
                    "date": "9 January 2022, 14.00",
                    "place" : "Mutfak Sanatlar?? Akademisi, ??stanbul",
                    "price": 550,
                    "imageName": "20",
                    "isFeatured": false
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }    }
}
