import SwiftUI

struct User: Identifiable, Comparable{
    let id = UUID()
    let firstName: String
    let lastName: String
    
    ///Conforming to comparable
    static func <(lhs:User, rhs:User) -> Bool{
        lhs.lastName < rhs.lastName
    }
}


struct TypeConformance: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct TypeConformance_Previews: PreviewProvider {
    static var previews: some View {
        TypeConformance()
    }
}
