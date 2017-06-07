

import UIKit

class UserInfo: NSObject {
    var name: String?
    var email: String?
    var password: String?
    var profileImageUrl: String?
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
    
}
