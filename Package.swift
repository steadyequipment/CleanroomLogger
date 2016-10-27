import PackageDescription

let package = Package(
	name: "CleanroomLogger",
	dependencies: []
)

#if os(OSX)
package.dependencies.append(
    .Package(url: "https://github.com/steadyequipment/CleanroomASL", majorVersion: 2, minor: 0)
    )
#endif
