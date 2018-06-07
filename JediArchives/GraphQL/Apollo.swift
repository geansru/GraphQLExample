import Foundation
import Apollo

final class Apollo {
  
  // MARK: - Private properties
  
  let client: ApolloClient

  // MARK: - Static properties

  static let shared = Apollo()
  
  init(url: URL = URL(string: "http://localhost:8080")!) {
    client = ApolloClient(url: url)
  }

}
