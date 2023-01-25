import MapKit
import SwiftUI

struct Intergrating_Mapkit: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    
    var body: some View {
        NavigationView {
            
                Map(coordinateRegion: $mapRegion, annotationItems: OldLocation.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        NavigationLink(destination: Text(location.name)) {
                            Circle()
                                .stroke(.green, lineWidth: 3)
                            .frame(width: 100)
                        }
                    }
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

struct OldLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

extension OldLocation {
    static let locations = [
        OldLocation(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        OldLocation(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
}
