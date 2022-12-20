import Vapor

public struct Server {
  private let env: Environment

  public init(env: Environment) {
    self.env = env
  }

  public init() throws {
    var env = try Environment.detect()
    try LoggingSystem.bootstrap(from: &env)
    self.init(env: env)
  }

  public static func configure(_ app: Application) throws {
    app.get("**") { request in
      return "Hello, vapor!"
    }
  }

  @discardableResult
  public func start() throws -> Application {
    let app = Application(env)
    Task(priority: .background) {
     // defer { app.shutdown() }
      do {
        try Server.configure(app)
        try app.server.start(address: .hostname("0.0.0.0", port: nil))
      } catch {
        fatalError(error.localizedDescription)
      }
    }
    return app
  }
}
