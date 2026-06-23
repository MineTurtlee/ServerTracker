// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Logging
import ArgumentParser

fileprivate let logger = Logger(label: "ServerTracker-Entrypoint")
let disURL = URL(string: "https://discord.com/api/users/@me")!

@main
struct ServerTracker: ParsableCommand {
    @Flag(help: "Configure the app")
    var configure: Bool = false
    
    func config() {
        var tok: String
        print("Passcode for the hash:", terminator: " ")
        let hash = readUserInput()
        while true {
            print("Bot token:", terminator: " ")
            let token = readUserInput()
            let conf = URLSessionConfiguration.default
            conf.urlCache = .none
            conf.httpAdditionalHeaders = ["User-Agent": "DiscordBot (https://discordpy.rtfd.io, v0.1)", "Authorization": "Bot \(token)"]
            let resp = URLSession(configuration: conf)
            var fucked = false
            resp.dataTask(with: disURL) { req, res, error in
                if error != nil {
                    print("Improper token passed or no internet connectivity: \(String(describing: error?.localizedDescription)), try again?")
                    fucked = true
                }
                
                if res is HTTPURLResponse {} else {
                    print("Not an HTTP response: \(String(describing: resp))")
                    fucked = true
                }
            }
            if fucked == true { continue }
            tok = token
            break
        }
        print("Prefix (This will not turn off slash commands):", terminator: " ")
        let prefix = readUserInput()
        
        // WRITING ENTIRELY HERE WE AREEEEEE
        let config = Config(hash: hash, token: enc(tok, withPassword: hash), prefix: prefix)
        let file = FileManager.default.currentDirectoryPath as NSString
        let path = URL(string: file.appendingPathComponent("config.json"))
        do {
            let encoder = try JSONEncoder().encode(config)
            try encoder.write(to: path!, options: .atomic)
        } catch {
            print("Failed to write file: \(error.localizedDescription)")
            return
        }
        print("You're now ready to run the app!")
        return
    }
    
    func run() {
        if configure == true {
            config()
            return
        }
        
        let file = FileManager.default.currentDirectoryPath as NSString
        let path = URL(string: file.appendingPathComponent("config.json"))
        
        var content: String
        do {
            content = try String(contentsOf: path!, encoding: .utf8)
        } catch {
            logger.error("An error occurred trying to read configuration: \(error.localizedDescription)")
            logger.error("Please try configuring with the app before running.")
            return
        }
        
        var config: Config
        do {
            config = try JSONDecoder().decode(Config.self, from: content.data(using: .utf8)!)
        } catch {
            logger.error("There was an error while trying to decode configuration: \(error.localizedDescription)")
            logger.error("Please fix the JSON file or reconfigure the app.")
            return
        }
        
        // MARK: Start the bot here
        // TODO: Bot initialization and work xd, except idk what I'm doing now gg
        let bot = TrackerBot(token: dec(config.token, withPassword: config.hash))
        bot.start()
    }
}
