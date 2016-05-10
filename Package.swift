import PackageDescription

let package = Package(
    name: "CSV",
    dependencies: [
                      .Package(url: "../CCSV", majorVersion: 1)
    ]
)