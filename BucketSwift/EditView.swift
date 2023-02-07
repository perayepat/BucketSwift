import SwiftUI

struct EditView: View {
    enum LoadingState{
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    var location : Location
    var onSave: (Location) -> Void /// On Save void for when we do get the location give nothing back
    
    @State  private var name: String
    @State  private var description: String
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                ///Showing the loading states
                Section("Nearby..."){
                    switch loadingState {
                    case .loading:
                        HStack{
                            Text("Loading")
                            Spacer()
                            ProgressView()
                        }
                        
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text("Page description here")
                                .italic()
                        }
                    case .failed:
                        Text("Try again later :(")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    //MARK: - New intialization using state value when your initializer doesnt need the init
    /// `@escaping` - keep the function memory alive stash is away for when it can be called later on for when the user presses save
    init(location:Location, onSave: @escaping (Location) -> Void){
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted { $0.title < $1.title }
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){ _ in}
    }
}
