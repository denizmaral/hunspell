// swift-tools-version: 5.9
//
// Swift Package wrapper for Hunspell.
//
// Exposes the C API only (`hunspell.h` — `Hunspell_create`, `Hunspell_analyze`,
// `Hunspell_stem`, …) under the module name `CHunspell`. The C++ implementation
// in `src/hunspell/*.cxx` is compiled as part of the target but not exposed to
// Swift — the C API is sufficient for everything KBModelBuilder /
// SuggestionDiagnostic need (morphological analysis, spell-check, stem
// retrieval) and avoids `std::string` / `std::vector` interop friction.
//
// Usage:
//   .package(path: "/path/to/hunspell")
//   …
//   import CHunspell
//   let h = Hunspell_create(affPath, dicPath)
//   defer { Hunspell_destroy(h) }
//   var slst: UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>? = nil
//   let n = Hunspell_analyze(h, &slst, "warte")
//   …
//
// Module-map at `src/hunspell/module.modulemap` controls header visibility —
// only `hunspell.h` is exported. The .hxx C++ headers are #included by the
// .cxx files internally.

import PackageDescription

let package = Package(
    name: "Hunspell",
    platforms: [
        .macOS(.v13),
        .iOS(.v15),
    ],
    products: [
        .library(name: "CHunspell", targets: ["CHunspell"]),
    ],
    targets: [
        .target(
            name: "CHunspell",
            path: "src/hunspell",
            // hunvisapi.h.in is the autoconf template; the already-generated
            // hunvisapi.h coexists in the same directory and is what we want
            // SwiftPM to compile against.
            exclude: ["Makefile.am", "hunvisapi.h.in"],
            publicHeadersPath: ".",
            cxxSettings: [
                // Disable __declspec(dllimport/dllexport) — we're statically
                // linking the C++ implementation into the Swift target.
                .define("HUNSPELL_STATIC"),
                // Internal includes (.hxx files referencing each other) work
                // when the source directory is on the header search path.
                .headerSearchPath("."),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx14
)
