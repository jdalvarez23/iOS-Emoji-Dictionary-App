//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by student19 on 2/15/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import Foundation

class Emoji: Codable {
    // initialize emoji property variables
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    // method that retrieves full path in which we can read/write data
    static var ArchiveURL: URL {
        // method that grants access to the Documents directory and enables it to read and write files in that directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // method that retrieves full path in which we can read/write data
        let archiveURL = documentsDirectory.appendingPathComponent("emoji_dictionary")
            .appendingPathExtension("plist")
        
        return archiveURL // return archiveURL
        
    }
    
    // initialize property list encoder
    static let encoder = PropertyListEncoder()
    
    // initialize property list decoder
    static let decoder = PropertyListDecoder()
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    // method that saves emoji array to file
    static func saveToFile(emojis: [Emoji]) {
    
        // encode Emoji array
        let encodedEmojiArray = try? encoder.encode(emojis)
        
        // method to write data to archiveURL path
        // "noFileProtection" allows the file to be overwritten in the future should the Note object be changed and need to be saved again
        try? encodedEmojiArray?.write(to: ArchiveURL, options: .noFileProtection)
        
    }
    
    // method that returns emoji array from file
    static func loadFromFile() -> [Emoji] {
        
        var returnEmojiArray: [Emoji]
        
        // decode Emoji array
        if let retrievedEmojiArray = try? Data(contentsOf: ArchiveURL),
            let decodedEmojiArray = try? decoder.decode(Array<Emoji>.self, from: retrievedEmojiArray) {
            
            print(decodedEmojiArray)
            
            returnEmojiArray = decodedEmojiArray // set value to decoded emoji array
            
            print("App is using decoded emojis")
            
        } else {
            // initialize sample emoji array
            let sampleEmojis: [Emoji] = [Emoji(symbol: "😀", name: "Grinning Face",
                                         description: "A typical smiley face.", usage: "happiness"),
                                   Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
                                   Emoji(symbol: "😍", name: "Heart Eyes",
                                         description: "A smiley face with hearts for eyes.",
                                         usage: "love of something; attractive"),
                                   Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
                                   Emoji(symbol: "🐢", name: "Turtle", description:
                                    "A cute turtle.", usage: "Something slow"),
                                   Emoji(symbol: "🐘", name: "Elephant", description:
                                    "A gray elephant.", usage: "good memory"),
                                   Emoji(symbol: "🍝", name: "Spaghetti",description: "A plate of spaghetti.", usage: "spaghetti"),
                                   Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
                                   Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
                                   Emoji(symbol: "📚", name: "Stack of Books",
                                         description: "Three colored books stacked on each other.",
                                         usage: "homework, studying"),
                                   Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
                                   Emoji(symbol: "💤", name: "Snore",
                                         description:
                                    "Three blue \'z\'s.", usage: "tired, sleepiness"),
                                   Emoji(symbol: "🏁", name: "Checkered Flag",
                                         description: "A black-and-white checkered flag.", usage:
                                    "completion")]
            
            returnEmojiArray = sampleEmojis // set value to sample emoji array
            
            print("App is using sample emojis")
            
        }
        
        return returnEmojiArray // return emoji array
        
    }

}
