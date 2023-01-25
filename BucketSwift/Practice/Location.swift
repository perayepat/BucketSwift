import Foundation
import CoreLocation


struct Location: Identifiable, Codable, Equatable{
    var id = UUID()
    var name : String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs:Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

extension Location{
    static let example = Location(name: "Buckingham Palace", description: "Where the quees lives", latitude: 51.501, longitude: -0.141)
}
