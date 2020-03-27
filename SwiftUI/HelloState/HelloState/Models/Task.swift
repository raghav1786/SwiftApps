
import Foundation
import SwiftUI

struct Task : Identifiable {
    let id = UUID()
    let name : String
    var isImp : Bool = false
}
