import Foundation
import XCTest
@testable import Gallery
struct MockUserDetailsEntityModel  {
    static func getUserDetailsModel() -> UserEntityModel {
        return UserEntityModel(id: 1, name: "testName", email: "test@gmail.com", phone: "456789765", website: "https://test.com")
    }
}
