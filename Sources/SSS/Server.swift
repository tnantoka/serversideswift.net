import Vapor
import VaporZewoMustache

public struct Server {
    let app: Application
    
    public init() {
        let app = Application()
        self.app = app
        
        VaporZewoMustache.Provider.includeFiles["layout"] = "layout.mustache"
        app.providers.append(VaporZewoMustache.Provider)
        
        app.get("/", handler: PostsController(application: app).index)
        app.resource("posts", controller: PostsController.self)
        
        Post.postDir = "\(app.workDir)/_posts/"
    }
    
    public func start(port: Int) {
        app.start(port: port)
    }
}