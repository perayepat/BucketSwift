import MapKit
import SwiftUI

struct Intergrating_Mapkit: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: Location.locations) { location in
                MapMarker(coordinate: location.coordinate,tint: .green)
            }
                .ignoresSafeArea()
            Color.red
                .ignoresSafeArea()
                .blendMode(.hue)
        }
    }
}

struct Intergrating_Mapkit_Previews: PreviewProvider {
    static var previews: some View {
        Intergrating_Mapkit()
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

extension Location {
    static let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
}
