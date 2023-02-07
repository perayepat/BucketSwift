import Foundation

struct Result: Codable{
    let query: Query
}

struct Query: Codable{
    let pages: [Int:Page]
}


struct Page: Codable, Comparable{
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    //MARK: - Conforming to comparable
    static func <(lhs:Page, rhs:Page) -> Bool{
        lhs.title < rhs.title
    }
}
