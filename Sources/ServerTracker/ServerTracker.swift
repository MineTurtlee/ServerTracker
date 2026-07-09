// The Swift Programming Language
// https://docs.swift.org/swift-book

// Any comments made in this project will NOT be deleted or removed in any way cuz yes
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Logging
import ArgumentParser
import Dispatch

fileprivate let logger = Logger(label: "ServerTracker-Entrypoint")
let disURL = URL(string: "https://discord.com/api/users/@me")! // why the fuck do you need a ! after the url, is it an optional or what the fuck
// phew ok you dont need that shit it was stupid asf
// fuck it it broke at build time

@main
struct ServerTracker: ParsableCommand {
    @Flag(help: "Configure the app")
    var configure: Bool = false
    // bloat
    var nemea = Nemea()
    
    func config() {
        var tok: String
        print("Passcode for the hash:", terminator: " ")
        let hash = readUserInput()
        while true {
            print("Token:", terminator: " ")
            let tokk = readUserInput()
            var boxshit: Boxshit
            
            boxshit = getToken(tokez: tokk)
            let (error, toke) = boxshit.value
            
            if error != true {
                var lerror: LoginError
                do {
                    lerror = try JSONDecoder().decode(LoginError.self, from: toke.data(using: .utf8)!)
                } catch {
                    lerror = LoginError(error: "toke", code: 0)
                }
                print("--- Token check failed! ---")
                print("Error: \(lerror.error)")
                print("Code: \(lerror.code)")
                print("--- Is the token valid? ---")
                continue
            }
            
            tok = toke
            break
        }
        print("Prefix (This will not turn off slash commands):", terminator: " ")
        let prefix = readUserInput()
        
        print("--- Basic Setup Done! ---")
        print("Do you want to include any presences? [yN]", terminator: " ")
        let presChoice = readUserInput()
        // I love custom **structing**
        var presList: [Presence] = []
        if presChoice.lowercased().starts(with: "y") {
            while true {
                // ask for pres details here
                // this code is leaked to viewers and early access but the codebase is public
                // build it yourself to see development progress i guess lmfao
                print("------ PRESENCE TYPE ------")
                print("Types, which will show cosmetically on Discord")
                print("Playing: 0")
                print("Streaming: 1")
                print("Listening: 2")
                print("Watching: 3")
                let type_string: String = input("Presence type (default game):")
                let type: Int = Int(type_string) ?? 0
                
                let title: String = input("Title of the presence:")
                
                // let details: String = input("Description of the presence:")
                
                // let state: String = input("Second line of the description:")
                
                // print("--- Image setup ---")
                // var key = input("Big image key:")
                // var desc = input("Big image description:")
                // let bigImage: Image = Image(key: key, description: desc)
                
                // key = input("Small image key:")
                // desc = input("Small image description:")
                // let smallImage: Image = Image(key: key, description: desc)
                
                // print("--- Misc setup ---")
                // let start: String = input("Start time in seconds (will be added to runtime):")
                // let start_int: Int64 = Int64(start) ?? 0
                
                // let end: String = input("End time in seconds (will also be added to runtime):")
                // let end_int: Int64 = Int64(end) ?? 0
                
                // let current = input("Team size (0 to disable)")
                // let max = input("Team size (0 to disable too)")
                // let party: Party = Party(current: Int(current) ?? 0, max: Int(max) ?? 0)
                
                print("--- All set! ---")
                // summary here, ill brb for some sky pics xd
                print("-- Summarized information of the presence you picked --")
                print("Type: \(type)")
                print("Title: \(title)")
                // print("Details: \(details)")
                // print("State: \(state)")
                // print("-= Big Image =-")
                // print("Key: \(bigImage.key)")
                // print("Description: \(bigImage.description)")
                // print("-= Small Image =-")
                // print("Key: \(smallImage.key)")
                // print("Description: \(smallImage.description)")
                // print("-= Miscellaneous =-")
                // print("Start time: \(start_int)")
                // print("End time: \(end_int)")
                
                let confirm = input("Is this correct?\nYou can always modify it to your likings in the config.json [yN]")
                if confirm.lowercased().starts(with: "y") {
                    presList.append(Presence(enabled: true,
                                             type: type,
                                             name: title,
                                             // details: details,
                                             // state: state,
                                             // large_image: bigImage,
                                             // small_image: smallImage,
                                             // start: start_int,
                                             // end: end_int,
                                             // party: party
                                            )
                    ) // brb
                    print("Added to the queue to add later!")
                    let more = input("Do you want to create another presence? [yN]")
                    if more.lowercased().starts(with: "y") {
                        // if you forget ill fade away
                        // im asking y to let me stayy
                        continue
                    } else { break }
                } else { continue }
            }
        } else {
            presList.append(Presence())
        }
        
        // WRITING ENTIRELY HERE WE AREEEEEE
        var config: Config
        if hash != "" {
            config = Config(hash: hash, token: enc(tok, withPassword: hash), prefix: prefix, presences: presList)
        } else {
            config = Config(hash: "", token: tok, prefix: prefix, presences: presList)
        }
        
        let file = FileManager.default.currentDirectoryPath as NSString
        let path = URL(fileURLWithPath: file.appendingPathComponent("config.json"))
        do {
            print("--- DEBUG INFOOOOO ---")
            print("PWD: \(file)")
            print("Wanted path: \(path)")
            let enc = JSONEncoder()
            
            // yayyy pretty printingggg >:))))))))
            enc.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
            let encoder = try enc.encode(config)
            try encoder.write(to: path, options: .atomic)
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
        let path = URL(fileURLWithPath: file.appendingPathComponent("config.json"))
        
        var content: String
        do {
            content = try String(contentsOf: path, encoding: .utf8)
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
        var tokk: String
        if config.hash != "" {
            tokk = dec(config.token, withPassword: config.hash)
        } else {
            tokk = config.token
        }
        
        let bot = TrackerBot(token: tokk, prefix: config.prefix, presences: config.presences)
        bot.start()
        dispatchMain()
    }
}
