import Foundation
import FirebaseFirestoreSwift

struct Event: Identifiable,Codable {
    @DocumentID var id: String?
    let name: String
    let category: String
    let date: String
    let place: String
    let price: Int
    let imageName: String
    let isFeatured: Bool


    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case date
        case place
        case price
        case imageName
        case isFeatured
    }
}
