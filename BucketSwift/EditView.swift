import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    var location : Location
    var onSave: (Location) -> Void /// On Save void for when we do get the location give nothing back
    
    @State  private var name: String
    @State  private var description: String
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    
                    dismiss()
                }
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
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){ _ in}
    }
}
