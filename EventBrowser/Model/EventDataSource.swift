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
    
    func getCategoryEventsWithIndex(index: Int) -> Event {
        return self.categoryEvents[index]
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
    
    func fetchAnEvent(name: String){

        let eventsRef = db.collection("events")
        eventsRef.whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, err) in
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
                    "name": "Serdar Ortaç",
                    "category": "Concert",
                    "date": "9 January 2022, 21.00",
                    "place" : "Küçükçiftlik Park, İstanbul",
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
                    "place" : "Küçükçiftlik Park, İstanbul",
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
                    "name": "Yaşar",
                    "category": "Concert",
                    "date": "11 January 2022, 21.00",
                    "place" : "Küçükçiftlik Park, İstanbul",
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
                    "name": "Gülşen",
                    "category": "Concert",
                    "date": "12 January 2022, 21.00",
                    "place" : "Küçükçiftlik Park, İstanbul",
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
                    "place" : "Küçükçiftlik Park, İstanbul",
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
                    "place" : "Cinemaximum Palladium, İstanbul",
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
                    "place" : "Cinemaximum İstinyePark, İstanbul",
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
                    "name": "Dayı: Bir Adamın Hikayesi",
                    "category": "Movie",
                    "date": "14 December 2021, 09.00",
                    "place" : "Cinemaximum Kanyon, İstanbul",
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
                    "name": "Aykut Enişte 2",
                    "category": "Movie",
                    "date": "1 January 2022, 12.15",
                    "place" : "Cinemaximum Palladium, İstanbul",
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
                    "place" : "Cinemaximum İstinyePark, İstanbul",
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
                    "place" : "Haldun Taner Sahnesi, İstanbul",
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
                    "name": "Bir Delinin Hatıra Defteri",
                    "category": "Theater",
                    "date": "12 January 2022, 12.00",
                    "place" : "Fişekhane Ana Sahne, İstanbul",
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
                    "name": "Mahşer-i Cümbüş",
                    "category": "Theater",
                    "date": "1 January 2022, 14.00",
                    "place" : "Trump Sahne, İstanbul",
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
                    "name": "Ağaçlar Ayakta Ölür",
                    "category": "Theater",
                    "date": "2 January 2022, 11.00",
                    "place" : "Kadıköy Hakl E.M., İstanbul",
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
                    "name": "Memleketimden İnsan Manzaraları",
                    "category": "Theater",
                    "date": "5 January 2022, 14.00",
                    "place" : "Caddebostan Kültür Merkezi, İstanbul",
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
                    "name": "Pastacılık",
                    "category": "Workshop",
                    "date": "3 January 2022, 11.00",
                    "place" : "Mutfak Sanatları Akademisi, İstanbul",
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
                    "place" : "Mutfak Sanatları Akademisi, İstanbul",
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
                    "name": "Dünya Mutfakları",
                    "category": "Workshop",
                    "date": "5 January 2022, 10.00",
                    "place" : "Mutfak Sanatları Akademisi, İstanbul",
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
                    "name": "Çikolata ve Dondurma",
                    "category": "Workshop",
                    "date": "7 January 2022, 11.00",
                    "place" : "Mutfak Sanatları Akademisi, İstanbul",
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
                    "place" : "Mutfak Sanatları Akademisi, İstanbul",
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
