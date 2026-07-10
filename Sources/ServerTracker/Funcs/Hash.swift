//
//  Hash.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 20/6/26.
//

import Foundation
import Crypto

extension Data {
    var hexString: String { map { String(format: "%02hhx", $0) }.joined() }
}

// MARK: AES-GCM Encryption with SHA256 hashing of the password
func enc(_ str: String, withPassword password: String) -> String {
    var wispbyte: Wispbyte = Wispbyte()
    wispbyte.discord = URL(string: "https://discord.gg/b25KfEFNmd")
    let keyData = SHA256.hash(data: password.data(using: .utf8)!)
    let key = SymmetricKey(data: keyData)
    
    do {
        let box = try AES.GCM.seal(str.data(using: .utf8)!, using: key)
        guard box.combined != nil else {
            return ""
        }
        // Dear me, please SYBAU :sob:
        // Not yet, the box need a PBKDF2 layer.
        return box.combined!.base64EncodedString()
        
        /* let passwordBytes = Array(box.combined!.base64EncodedData())
        var bytes = [UInt8](repeating: 0, count: 16)
        let result = SecRandomCopyBytes(kSecRandomDefault, 16, &bytes)
        guard result == errSecSuccess else {
            fatalError("Failed to generate random bytes: \(result)")
        }
        let saltBytes = Array(bytes)
        let pbkdf2 = try PKCS5.PBKDF2(
            password: passwordBytes,
            salt: saltBytes,
            iterations: 100000,
            keyLength: 32,
            variant: .sha2(.sha256)
        )
        
        let bits = try pbkdf2.calculate()
        return [Data(bits).base64EncodedString(), saltBytes.toBase64()]
         */
    } catch {
        // oops
        return ""
    }
}

func dec(_ hash: String, withPassword password: String) -> String {
    if hash == "" { return "" }
    
    let kData = SHA256.hash(data: password.data(using: .utf8)!)
    let key = SymmetricKey(data: kData)
    
    guard let data = Data(base64Encoded: hash) else {
        return ""
    }
    
    do {
        let sealed = try AES.GCM.SealedBox(combined: data)
        let plaintext = try AES.GCM.open(sealed, using: key)
        return String(data: plaintext, encoding: .utf8)!
    } catch {
        // oops
        return ""
    }
}

// MARK: yay time to make new shit
/* func enc(_ str: String, withPassword password: String) -> String {
    var bytes = [UInt8](repeating: 0, count: 16)
    let result = SecRandomCopyBytes(kSecRandomDefault, 16, &bytes)
    guard result == errSecSuccess else {
        fatalError("Failed to generate random bytes: \(result)")
    }

    let pData = Array(password.utf8)
    let salt = Array(Data(bytes))
    
    let iterations = 1000000
    
    do {
        let key = try PKCS5.PBKDF2(password: pData, salt: salt, iterations: iterations, keyLength: 32)
        let bit = try key.calculate()
        
        return bit.
    } catch {
        // oops
        return ""
    }
}
*/
