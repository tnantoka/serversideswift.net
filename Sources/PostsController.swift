import Vapor

class PostsController: Controller {
    typealias Item = Post
    
    let app: Application
    
    required init(application: Application) {
        app = application
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        let posts = Post.all
        return try app.view("Posts/index.mustache", context: [
                                                             "posts": posts.map { $0.attributes },
                                                             ])
    }
    
    func show(request: Request, item post: Post) throws -> ResponseRepresentable {
        return try app.view("Posts/show.mustache", context: [
                                                             "post": post.attributes,
                                                             ])
    }
}

