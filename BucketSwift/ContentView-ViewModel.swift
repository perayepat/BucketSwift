import Foundation
import MapKit

//MARK: - Make this view model exclusive to the content view
/// `Main Actor -` Allows the view model to make UI updates 
extension AddingUsersLocation {
    @MainActor class ViewModel: ObservableObject {
        
        @Published  var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published  private(set) var locations = [Location]()
        @Published  var selectedPlace: Location?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        /// `Saving and Loading data from disk`
        init(){
            
            //Loading
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        //Saving Using data to disk
        func save(){
            do{
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite,.completeFileProtection])
            } catch{
                print("Unable to show data ALERT")
            }
        }
        
        func addLocation(){
            let newLocation = Location(name: "New Location",
                                       description: "",
                                       latitude: mapRegion.center.latitude,
                                       longitude: mapRegion.center.longitude)
            locations.append(newLocation)
        }
        
        func update(location:Location){
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace){
                // find where it is in the array and overwrite it in the array
                locations[index] = location
            }
        }
    }
}
