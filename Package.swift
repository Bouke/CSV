import PackageDescription

let package = Package(
    name: "CSV",
    dependencies: [
        .Package(url: "https://github.com/Bouke/CCSV.git", majorVersion: 1),
    ]
)
