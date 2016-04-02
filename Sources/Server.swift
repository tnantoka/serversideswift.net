import Vapor
import VaporZewoMustache

struct Server {
    let app: Application
    
    init() {
        let app = Application()
        self.app = app
        
        VaporZewoMustache.Provider.includeFiles["layout"] = "layout.mustache"
        app.providers.append(VaporZewoMustache.Provider)
        
        app.get("/", handler: PostsController(application: app).index)
        app.resource("posts", controller: PostsController.self)
        
        Post.postDir = "\(app.workDir)/_posts/"
    }
    
    func start(port: Int) {
        app.start(port: port)
    }
}