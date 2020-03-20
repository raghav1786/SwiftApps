import UIKit
import CryptoKit
//** CryptoKit helps in **
// Interoperate between Platforms
//  Authenticate with your service
//  Implement a specification
// Build on top of CoreCrypto
// Hand Tuned Assemnly Code


// Generating Hashes
// Hash Function - used to map data(can be raw, vedio ,audio anything) of arbitary size
// to fixed sized values called digest
// Hash Value -always unique
// - generate key from specific Input Data
// - if input data changes then  key changes.
// - purpose:- if local file data changes means malware has been addded MD5 and SHA
//  SHA 256 SHA 384 SHA 512
if let data = "test CryptoSwift hashing".data(using: .utf8) {
    let digest = SHA256.hash(data: data)
    print(digest)
}


// Encypt Data
// -[AES-GCM] and [ChaChaPoly-for Mobiles]

// ***Symmetric key cryptograpghy***
let key = SymmetricKey(size: .bits256)

if let filePath = Bundle.main.path(forResource: "TestFile", ofType: "txt"),
    //file loaded
    let encryptedData = FileManager.default.contents(atPath: filePath),
    //encypt using AESGCM(Authenticated Encryotion)-new
    let sealed = try? AES.GCM.seal(encryptedData, using: key),
    //encypts and seal data using ChaCha20-Poly1305
    let cryptedBox = try? ChaChaPoly.seal(encryptedData, using: key) {
    
    //created a sealed b ox with encypted data
    let sealedBox = try ChaChaPoly.SealedBox(combined: cryptedBox.combined)
    //decypt it with private key shared
    if let decryptedData = try? ChaChaPoly.open(sealedBox, using: key) {
        print(decryptedData)
    }
}


// Data Authentication
// - Verify Identity of the user.before allowing him to send data on our server

if let filePath = Bundle.main.path(forResource: "TestVedio", ofType: "mp4") {
    let data = FileManager.default.contents(atPath: filePath)!
    let key =  SymmetricKey(size: .bits256)
    // Message Authentication Cookies
    let authentication = HMAC<SHA256>.authenticationCode(for: data, using: key)
    let authenticatedData = Data(authentication)
    // Travels Across Network
    
    if (HMAC<SHA256>.isValidAuthenticationCode(authenticatedData, authenticating: data, using: key)) {
    print("Validated :)")
    }
    
    let sealedBox = try ChaChaPoly.SealedBox(combined: data)
    let mapData = try ChaChaPoly.open(sealedBox, using: key)
    print(mapData)
}

// ***PUBLIC KEY CRYPTOGRAPHY***  - using P-256 P 384 P512  or Curve25519-new
//Performing Key Agreement
// -Key Agreement Protocol
// Two Parties each with their own seprate private key , establish a shared secret between them
// Ones Public Key and Others Private key
// prevent unauthorized person to acess it

let salt = "Salt".data(using: .utf8)!
let firstPrivateKey = P256.KeyAgreement.PrivateKey()
let firstPublicKey = firstPrivateKey.publicKey
let secondPrivateKey = P256.KeyAgreement.PrivateKey()
let secondPublicKey = secondPrivateKey.publicKey

let firstSharedSecret = try! firstPrivateKey.sharedSecretFromKeyAgreement(with: secondPublicKey)
let firstSymmetricKey = firstSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)

let secondSharedSecret = try! secondPrivateKey.sharedSecretFromKeyAgreement(with: firstPublicKey)
let secondSymmetricKey = secondSharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: salt, sharedInfo: Data(), outputByteCount: 32)


if firstSymmetricKey == secondSymmetricKey {
    print("Authentication Succesful both have same keys")
}

// Verify data with signatures
// Digital Signatures:- verify authenticity of users
// - uses asymmetric cryptography
// - used in https financial bank transactions.
// - Curve15519, P521 ,P384,P256

//create private key and store it in safe place
let privateKey = P256.Signing.PrivateKey()

// starting ffrom private key , create public key to share.
let publicKey = privateKey.publicKey
let publicKeyData = publicKey.rawRepresentation
// Store Private key in keychain

if let data = "testDigitalSignature".data(using: .utf8) ,
    let signature = try? privateKey.signature(for: data) {
    print(signature.derRepresentation)
    // share the data and corresponding public key with it

    // Secure Enclave - used for additional layer of security -hardware based key manager
    //isolated from main manager
    //used for touchID faceID
    
    if !SecureEnclave.isAvailable {
        //for device without SecureEnclave
    }
    //let privateKey = SecureEnclave.P256.Signing.PrivateKey(accessControl: accessControl,
    // authenticationContext :authContext)
    //acess Control is there
    // requires user presence by password device or touchID or faceID
    // key is for this device only.

//everyone with public key can check signature
    if publicKey.isValidSignature(signature, for: data) {
         print("Signature is authenticated and is OK")
    }
}


