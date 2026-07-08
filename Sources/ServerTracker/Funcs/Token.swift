//
//  Token.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 6/7/26.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@Sendable
func token(token: String) async -> (Bool, String) {
    let conf = URLSessionConfiguration.default
    conf.urlCache = .none
    conf.httpAdditionalHeaders = ["User-Agent": "DiscordBot (https://discordpy.rtfd.io, v0.1)", "Authorization": "Bot \(token)"]
    let resp = URLSession(configuration: conf)
    /* resp.dataTask(with: disURL) { req, res, error in
        if error != nil {
            print("Improper token passed or no internet connectivity: \(String(describing: error?.localizedDescription)), try again?")
            fucked = true
        }
        
        if res is HTTPURLResponse {} else {
            print("Not an HTTP response: \(String(describing: resp))")
            fucked = false
        }
    } */
    var (data, res): (Data, URLResponse)
    do {
        (data, res) = try await resp.data(from: disURL)
    } catch { return (false, "\(error)") }
    
    if let response = res as? HTTPURLResponse {
        if response.statusCode >= 400 {
            return (false, String(data: data, encoding: .utf8) ?? "nil")
        }
        
        return (true, token)
    } else {
        return (false, "Not an HTTP Response")
    }
    
    // edge case, idc about the warning yummmm
    return (false, "nil")
}

func getToken(tokez: String) -> Boxshit {
    let semaphore = DispatchSemaphore(value: 0)
    let shit = Boxshit()
    
    Task.detached {
        shit.value = await token(token: tokez)
        semaphore.signal()
    }
    
    semaphore.wait()
    return shit
}

final class Boxshit: @unchecked Sendable {
    var value: (Bool, String) = (false, "Unknown error")
}
