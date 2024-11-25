//
//  FeedGenerator.swift
//  seconda
//

import CSFeedKit
import System

struct FeedGenerator {
    static func generate(commitList: [CommitNode]) throws {
        let channel = CSRSSFeedChannel(
            title: "swiftlang/swift CHANGELOG.md",
            link: "https://github.com/tokizuoh/seconda/swift/rss.xml",
            description: "description"
        )
        
        let items: [CSRSSFeedItem] = try commitList.map { commit in
            let title = String(commit.message.prefix(50)) + (commit.message.count > 50 ? "..." : "")
            let cleanedTitle = title.replacingOccurrences(of: "\\s*(\\n|\\r)\\s*", with: " ", options: .regularExpression)
            
            if let pubDate = ISO8601DateFormatter().date(from: commit.committedDate) {
                return CSRSSFeedItem(
                    title: cleanedTitle,
                    link: commit.url,
                    description: commit.message,
                    pubDate: pubDate,
                    creator: nil,
                    enclosure: nil
                )
            } else {
                throw SecondaError.invalidDateFormat
            }
        }
        channel.items = items
        
        let feed = CSRSSFeed()
        feed.channels = [channel]
        
        try write(feed: feed)
    }
    
    private static func write(feed: CSRSSFeed) throws {
        guard let workingDirectory = ProcessInfo.processInfo.environment["SECONDA_WORKING_DIRECTORY"],
              let fileURL = URL(filePath: FilePath("\(workingDirectory)/Generated/rss.xml")) else {
            throw SecondaError.emptyWorkingDirectory
        }
        
        let content = feed.xmlElement().xmlString(options: .nodePrettyPrint)
        try content.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
