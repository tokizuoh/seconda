//
//  GraphQLResponse.swift
//  seconda
//

struct GraphQLResponse: Codable {
    struct Data: Codable {
        struct Repository: Codable {
            struct Object: Codable {
                struct History: Codable {
                    struct Edge: Codable {
                        let node: CommitNode
                    }
                    let edges: [Edge]
                }
                let history: History
            }
            let object: Object?
        }
        let repository: Repository?
    }
    let data: Data?
}
