import UIKit
import RxSwift
import RxCocoa

class OpenClass{
    init(
        input:(String, Bool),
        dependency:(String, String))
    {
        print(input)
        print(dependency)
    }
}
let open = OpenClass(input: ("ss",true), dependency: ("s", "d"))

extension String: Error{}
func auth(_ user: String) throws -> Bool {
    throw "Failed"
}
func authPassword(_ user: String) -> Bool{
    return true
}
func authUser(method: (String) throws -> Bool) throws {
    try method("twostraws")
    print("Success!")
}
do {
    try authUser(method: authPassword)
} catch {
    print("D' oh")
}

func authuser2(method:(String) throws -> Bool) rethrows{
    try method("twoStraws")
    print("success!")
}
