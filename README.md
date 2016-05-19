# Swift wrapper for libcsv

## Usage
In your `Package.swift`, include the dependency:

    .Package(url: "https://github.com/Bouke/CSV.git", majorVersion: 1),

Install `libcsv` using the package manager of your choice. For example using Homebrew:

    brew install libcsv

Now you can build your package using `swift build`. However if it cannot find
the `libcsv` library, for example if installed with Homebrew, you have to
specify the library path:

    swift build -Xcc -I`brew --prefix`/opt/libcsv/include -Xlinker -L`brew --prefix`/opt/libcsv/lib
