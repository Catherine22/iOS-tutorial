func sayHello(name: String) {
   print("Hello, \(name)!")
}


if CommandLine.arguments.count != 2 {
   print("Usage: hello Name")
} else {
   let name = CommandLine.arguments[1]
   sayHello(name: name)
}
