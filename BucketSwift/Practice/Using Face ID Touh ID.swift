import LocalAuthentication
import SwiftUI

struct Using_Face_ID_Touh_ID: View {
    @State var isUnlocked = false
    var body: some View {
        VStack{
            if isUnlocked{
                Text("Unlocked")
            } else {
                Text("Lock")
            }
        }.onAppear(perform: authenticate)
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success,authenticationError in
                if success {
                    //Successful auth
                    isUnlocked = true
                } else {
                    
                }
            }
        } else {
            //no Biometrics
        }
    }
}

struct Using_Face_ID_Touh_ID_Previews: PreviewProvider {
    static var previews: some View {
        Using_Face_ID_Touh_ID()
    }
}
