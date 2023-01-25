import LocalAuthentication
import SwiftUI

struct Using_Face_ID_Touh_ID: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success,authenticationError in
                if success {
                    //Successful auth
                } else {
                    
                }
            }
        } else {
            
        }
    }
}

struct Using_Face_ID_Touh_ID_Previews: PreviewProvider {
    static var previews: some View {
        Using_Face_ID_Touh_ID()
    }
}
