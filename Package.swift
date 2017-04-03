import PackageDescription

let package = Package(
    name: "FlikrFeed",
    dependencies: [
        .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", majorVersion: 3, minor: 1)
    ]
)
