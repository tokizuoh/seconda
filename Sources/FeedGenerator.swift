//
//  FeedGenerator.swift
//  seconda
//

import CSFeedKit

struct FeedGenerator {
    static func generate(commitList: [CommitNode]) {
        let channel = CSRSSFeedChannel(
            title: "swiftlang/swift CHANGELOG.md",
            link: "https://github.com/tokizuoh/seconda/swift/rss.xml",
            description: "description"
        )
        
        var items: [CSRSSFeedItem] = []
        commitList.forEach { commit in
            let title = String(commit.message.prefix(50)) + (commit.message.count > 50 ? "..." : "")
            let cleanedTitle = title.replacingOccurrences(of: "\\s*(\\n|\\r)\\s*", with: " ", options: .regularExpression)

            let item = CSRSSFeedItem(
                title: cleanedTitle,
                link: commit.url,
                description: commit.message
            )
            items.append(item)
        }
        channel.items = items
        
        let feed = CSRSSFeed()
        feed.channels = [channel]
        
        write(feed: feed)
        
    }
    
    private static func write(feed: CSRSSFeed) {
        let fileManager = FileManager.default
        let currentDirectoryURL = URL(fileURLWithPath: fileManager.currentDirectoryPath)
        let fileURL = currentDirectoryURL.appendingPathComponent("rss.xml")
        
        let content = feed.xmlElement().xmlString(options: .nodePrettyPrint)
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("error: \(error)")
        }
    }
}
