import UIKit

// ***SYSTEM FEATURES***
// they dont need Cyptokit
// Protect Data in Device
do {
    if let filePath = Bundle.main.path(forResource: "TestVedio", ofType: "mp4") {
        let data = FileManager.default.contents(atPath: filePath)!
        //writing data to file securly.
        try data.write(to : URL(string: filePath)!,options: .completeFileProtection)
    }
} catch {
    
}

// Protect Credentials and Keys
// -Use Keychains instead of UserDefaults
// -LocalKeychain or iCloudKeychain

import CloudKit
// saving record on iCloud Database that will be available on all shared devices.

//Secure Network Connection :- using TLS:Transport Layer Security.
//strong security and greate Performance.
//Network framework :-
import Network
let conn = NWConnection(host: "imap.mail.me.com", port: .imaps, using: .tls)
conn.start(queue: .main)
// URLSession
let url = URL(string: "https://www.google.com")!
let task = URLSession.shared.dataTask(with: url) { (data,response,error) in
    
}
task.resume()
// Get data from Content Deleivery Networks
//:- Certificate
// dont use certidficate parser
// use Sectrust
//SecTrustEvaluateAsyncWithError(trust, queue ) {(trust,success,error) in
//
//}
