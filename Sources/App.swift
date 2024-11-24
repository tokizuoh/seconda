import Foundation

func fetchLatestCommitList(
    owner: String,
    repo: String,
    first: Int,
    filePath: String,
    token: String
) async throws -> [CommitNode]? {
    let url = URL(string: "https://api.github.com/graphql")!
    
    let fileURL = Bundle.module.url(forResource: "Query", withExtension: "graphql")!
    let query = try String(contentsOf: fileURL, encoding: .utf8)
    
    let variables: [String: Any] = [
        "owner": owner,
        "name": repo,
        "first": first,
        "filePath": filePath
    ]
    
    let body: [String: Any] = [
        "query": query,
        "variables": variables
    ]
    
    let httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.httpBody = httpBody
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    let graphQLResponse = try JSONDecoder().decode(GraphQLResponse.self, from: data)
    
    return graphQLResponse
        .data?
        .repository?
        .object?
        .history
        .edges
        .map(\.node)
}

@main
struct App {
    static func main() async {
        let owner = "swiftlang"
        let repo = "swift"
        let filePath = "CHANGELOG.md"
        
        #if DEBUG
        let fileURL = Bundle.module.url(forResource: "token", withExtension: "txt")!
        let token = (try! String(contentsOf: fileURL, encoding: .utf8)).trimmingCharacters(in: .whitespacesAndNewlines)
        #else
        let token = ""
        #endif
        
        do {
            if let commitList = try await fetchLatestCommitList(
                owner: owner,
                repo: repo,
                first: 5,
                filePath: filePath,
                token: token
            ) {
                FeedGenerator.generate(commitList: commitList)
            } else {
                print("No commit found for the specified file.")
            }
        } catch {
            print("Failed to fetch commit: \(error)")
        }
    }
}
