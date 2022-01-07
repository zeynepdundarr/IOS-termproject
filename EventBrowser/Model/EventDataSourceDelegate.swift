import Foundation

protocol EventDataSourceDelegate {
    func eventListLoaded()
    func eventDetailLoaded(event: Event)
    func categoryEventListLoaded(eventList: [Event])
}
