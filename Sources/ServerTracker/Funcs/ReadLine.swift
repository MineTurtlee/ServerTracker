//
//  ReadLine.swift
//  ServerTracker
//
//  Created by GreenyCells (Mineturtlee) on 19/6/26.
//

func readUserInput() -> String {
    while true {
        if let line = readLine() {
            if line != "" { return line }
        } else {
            print("kaput, try again!", terminator: " ")
        }
    }
}

func input(_ quest: String) -> String {
    print(quest, terminator: " ")
    return readUserInput()
}
