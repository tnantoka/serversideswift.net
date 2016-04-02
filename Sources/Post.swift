import Foundation
import Vapor
import JSON
import String

final class Post {
    static var postDir = "./"

    let id: Int
    let path: String

    convenience init?(filename: String) {
        self.init(id: filename.split(by: ".")[0])
    }
    
    init?(id: String) {
        guard let id = Int(id) else { return nil }
        let path = "\(Post.postDir)\(id).html"
        guard NSFileManager.defaultManager().fileExists(atPath: path) else { return nil }
        self.id = id
        self.path = path
    }
    
    static var all: [Post] {
        do {
            let filenames = try NSFileManager.defaultManager().contentsOfDirectory(atPath: postDir)
            let posts = filenames.map { Post(filename: $0) }.flatMap { $0 }
            return posts.sorted { $0.id > $1.id }
        } catch {
            return []
        }
    }
    
    lazy var content: [String] = {
        do {
            let content = try String(contentsOfFile: self.path, encoding: NSUTF8StringEncoding)
            return content.split(by: "---\n") + [""]
        } catch {
            return ["", ""]
        }
    }()
    
    lazy var frontmatter: JSON = {
        do {
            return try JSONParser().parse(Data("{\(self.content[0])}"))
        } catch {
            return [:]
        }
    }()
    
    lazy var title: String = {
        return self.frontmatter["title"]?.string ?? ""
    }()
    
    lazy var date: String = {
        return self.frontmatter["date"]?.string ?? ""
    }()
    
    lazy var body: String = {
        return self.content[1]
    }()
    
    var attributes: [String: String] {
        return [
                   "id": String(id),
                   "title": title,
                   "body": body,
                   "date": date,
        ]
    }
}

extension Post: StringInitializable {
    convenience init?(from string: String) throws {
        self.init(id: string)
    }
}