//
//  ViewControllergame.swift
//  Goverment app
//
//  Created by Prahlad on 7/6/19.
//  Copyright © 2019 Prahlad. All rights reserved.
//

import UIKit

// A game where the user is presented with a random item of rubbish and must select
// the correct bin to put it in.

// An "enum" lets us use meaningful names in the program, instead of magic numbers.
// See: https://en.wikipedia.org/wiki/Magic_number_(programming)#Unnamed_numerical_constants
// and: https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
// We declare it with type Int, because we will match it with the Int tag of
// a bin button in the UI.
// By default, for Int enums, numbering starts at 0. So:
// green = 0, yellow = 1, red = 2
enum BinColor: Int {
    case green, yellow, red
}

// A "struct" lets us create an logical object in our code that represents an
// entity in the business domain that is the concern of the program.
// Using a struct allows us to express the program's logic in language describing the domain.
// See: https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
// Our program's business domain is "rubbish", so we create the concept of
// a RubbishItem.
struct RubbishItem {
    var image: String
    var name: String
    var correctBinColor: BinColor
}

class ViewControllergame: UIViewController {
    @IBOutlet weak var Imgitem: UIImageView!
    @IBOutlet weak var Lblanswer: UILabel!
    @IBOutlet weak var Lblitemname: UILabel!

    // These fields are declared here so we can use them in them in the click handlers
    // Their value will be available, and the same, everywhere in this view.
    
    // The currentRubbishItem is the one being presented to the user right now.
    var currentRubbishItem: RubbishItem!
    // The exclamation mark lets the compiler know that while we don't set a value here,
    // we will set a value for this before we use it.
    // The rubbishItems provide us a collection to choose from randomly. It is an array.
    var rubbishItems: [RubbishItem]!

    // This click handler is linked to all three bins in the UI.
    // All bins call this when they are clicked, and the sender.tag gives away which bin it is,
    // because we set a different tag for each one in the UI designer.
    @IBAction func clickBin(_ sender: UIButton) {
        // .rawValue gives us the Int value of the enum to compare with the tag.
        let correctBinTag = currentRubbishItem.correctBinColor.rawValue
        let isCorrectBin = sender.tag == correctBinTag
        // Set the result in the UI
        self.Lblanswer.text = isCorrectBin ? "Correct": "Incorrect"
    }

    // The user is requesting a new rubbish item.
    @IBAction func Btnstart(_ sender: UIButton) {
        // Remove any previous answer in the UI.
        Lblanswer.text = ""
        
        // Select a rubbish item at random from the collection.
        // @TODO - enforce that it is not the same as the last one.
        let index = Int.random(in:0...rubbishItems.count - 1)
        currentRubbishItem = rubbishItems[index]
        
        // Present the rubbish item to the user in the UI.
        Imgitem.image = UIImage(named: currentRubbishItem.image)
        Lblitemname.text = currentRubbishItem.name
    }
    
    // This code runs when the view is loaded, and is where we populate our collection of rubbishItems.
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Create 3 items of rubbish
        let paper = RubbishItem(image: "Paper", name: "Paper", correctBinColor: BinColor.yellow)
        let plastic = RubbishItem(image: "PlasticBag", name: "Plastic Bag", correctBinColor: BinColor.red)
        let leaves = RubbishItem(image: "Leaves", name: "Leaves", correctBinColor: BinColor.green )
        
        // We can easily add any amount of rubbish items in the future, with no change to the rest of the
        // program's logic or complexity. This is a good design - it is an indication that we have a good
        // separation of concerns.
        // See: https://en.wikipedia.org/wiki/Separation_of_concerns
        rubbishItems = [paper, plastic, leaves]
    }
}
