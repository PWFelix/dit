//
//  ViewControllergame.swift
//  Goverment app
//
//  Created by Prahlad on 7/6/19.
//  Copyright © 2019 Prahlad. All rights reserved.
//

import UIKit

//  Rubbish items have 3 properties
struct RubbishItem {
    var image = ""
    var name = ""
    //  The answer is the tag on the button of the bins
    var binBtnTag = 0
    // tags: 0 - green
    // 1 - yellow
    // 2 - red
}

class ViewControllergame: UIViewController {
    @IBOutlet weak var Imgitem: UIImageView!
    @IBOutlet weak var Lblanswer: UILabel!
    @IBOutlet weak var Lblitemname: UILabel!

    var currentRubbishItem: RubbishItem!
    var rubbish: [RubbishItem]!

    @IBAction func clickBin(_ sender: UIButton) {
        //  All bins call this when they are clicked and the tag gives away which bin it is
        let correct = sender.tag == currentRubbishItem.binBtnTag
        self.Lblanswer.text = correct ? "Correct": "Incorrect"
    }

    @IBAction func Btnstart(_ sender: UIButton) {
        Lblanswer.text = ""
        let index = Int.random(in:0...rubbish.count - 1)
        currentRubbishItem = rubbish[index]
        Imgitem.image = UIImage(named: currentRubbishItem.image)
        Lblitemname.text = currentRubbishItem.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Create 3 items of rubbish
        let paper = RubbishItem(image: "New-Design-100-Wood-Pulp-A4-Copy-Paper", name: "Paper", binBtnTag: 1)
        let plastic = RubbishItem(image: "plastic-bag-500x500", name: "Plastic Bag", binBtnTag: 2)
        let leaves = RubbishItem(image: "thumbnail2.png84965a65-47d6-4871-b253-f8979af85e4bOriginal", name: "Leaves", binBtnTag: 0 )
        
        // We can easily add any ammount of 	rubbish items in the future
        rubbish = [paper, plastic, leaves]
        // Do any additional setup after loading the view.
    }
}
