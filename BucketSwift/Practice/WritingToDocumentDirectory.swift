import SwiftUI

struct WritingToDocumentDirectory: View {
    var body: some View {
        Button("Write to directory") {
            let str = "Test Message"
            let url = getDocumentsDirectory().appendingPathComponent("message.txt")
            
            do {
                //NS uses utf16 while swiftui uses utf8
                try str.write(to: url,atomically: true,encoding: .utf8)
                let input  = try String(contentsOf: url)
                print("Input: \(input)")
            } catch{
                print(error.localizedDescription)
            }
        }
    }
}

struct WritingToDocumentDirectory_Previews: PreviewProvider {
    static var previews: some View {
        WritingToDocumentDirectory()
    }
}


extension WritingToDocumentDirectory{
    
    //Finding the users documents directory
    //Gets backed up to icloud and gets deleted when its deleted
    //No data limit
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
