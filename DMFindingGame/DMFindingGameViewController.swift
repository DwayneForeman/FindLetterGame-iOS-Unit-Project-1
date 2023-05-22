//
//  DMFindingGameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit

/**
 1.1 Create the user interface in the `Main` file. See the provided screenshot for how the UI should look. Feel free to customize the colors, font, etc. - DONE
 */
class DMFindingGameViewController: UIViewController {
    
    /**
     2.1 Create IBOutlets for the target letter label and the score label. - DONE
     2.2 Create an IBOutlet collection for the letter buttons. - DONE
     */
    
    
    @IBOutlet weak var letterLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    /**
     These variables will help us with the gameplay. You do not need to modify this code.
     */
    var targetLetter = ""
    var randomLetters = [String]()
    var score = 0
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    /**
     We're starting a new round as soon as the screen loads. You do not need to modify this code.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    /**
     3.1 Assign the `targetLetter` variable to a random letter from the `letters` array. - DONE
     3.2 Call the `generateRandomLetters` function and assign the result to the `randomLetters` variable. Hint: We want the number of letters to be the number of letters buttons that we have. - DONE
     3.3 Call the `updateTargetLetterLabel` and `updateLetterButtons` functions. - DONE
     */
    func newRound() {
        
        targetLetter = letters.randomElement()!
        randomLetters = generateRandomLetters(numLetters: 12)
        updateTargetLetterLabel()
        updateLetterButtons()
        
    }
    
    /**
     4.1 Return an array of letters. There should be as many letters as `numLetters`.
     The array should include the target letter. The rest of the letters should be random. A letter should show up in the array only once. The order of the letters should be random. - DONE
     
     This is a tricky function, but feel free to run the provided test in `DMFindingGameTests` to know if your code is correct. Let your Tech Lead know if you need help. :)
     */
    func generateRandomLetters(numLetters: Int) -> [String] {
        
        // Let's FIRST make sure we include the targerLetter into our array that we're going to return
        //  Rmeeber: Puttinge teh ragetLetter in brackets automcatically creates the STring array which we need to return
        var arrayOfLetters = [targetLetter]
        
        // Now we need to add 11 more numbers into the "arrayOfLetters" under two conditions
        // 1st Condition - While the count is less than 12 which is represented by "numLetters"
        // 2nd Condition - Making sure a number within the array doesn NOT appear twice
        // Solution - After researching, we can use a while loop...While said conditions are true let the code in {} execute
        
        while arrayOfLetters.count < numLetters {
            //Will run while the count inside the array is NOT more than 12
            
            let randomLetter = letters.randomElement()!
            // Creating a new constant and setting it equal to our array above and grabbing a randon element from it. Also .randomElement is an optional so we need to FORCE unwrap it.
            
            if !arrayOfLetters.contains(randomLetter) {
                // ONLY IF, our arrayOfLetters does NOT (hence the ! negate) contain the same randomeLetter we previously generated and sent to the rayy them we will execute the block below:
                
                arrayOfLetters.append(randomLetter)
                // Addind the number which we confired is NOT already in the array to the array
                
            }
            
        }
        
        // Since Arrays are in order and we want NO ORDER lets shake it around a bit using the buuilt in shuffle method
        arrayOfLetters.shuffle()
        
        // let's return our array
        return arrayOfLetters
        
        
        
    }
    
    /**
     5.1 Check if the `selectedLetter` is equal to the `targetLetter` and update the `score` variable accordingly. - DONE
     
     Feel free to run the provided test in `DMFindingGameTests` to know if your code is correct.
     */
    func calculateNewScore(selectedLetter: String) {
        
        // If the letter the user selects is equal to the targetLetter diplayed then add 1 point
        if selectedLetter == targetLetter {
            score += 1
            //Also, add/run the updateScore function below so the score can be updated accordingly
            updateScoreLabel()
        }
        
    }
    
    /**
     6.1 Create an IBAction that gets run when the user taps on a letter button. - DONE
     6.2 Call the `calculateNewScore` function and pass in the selected letter. Hint: You can get access to the selected letter using the `sender`'s `titleLabel`. - DONE
     6.3 Call the `newRound` function to start a new round. - DONE
     */
    
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        
        // Printing the titleLabel text by tapping into the sender which is our variable for each UI button we click since I've linked them all
        print("Letter \(sender.titleLabel!.text!) was tapped")
        
        // Calling calculate score function and passing in the button titleLabel text that was clicked to update score
        calculateNewScore(selectedLetter: sender.titleLabel!.text!)
        
        // Starting a new round after a hit or miss
        newRound()
        
    }
    
    
    /**
     7.1 Update the `targetLetterLabel`'s text to be the `targetLetter`. - DONE
     */
    func updateTargetLetterLabel() {
        
        // As my letterLabel is a UIlabel I can tap into it's text and change it by using the .text property
        letterLabel.text = targetLetter
        
    }
    
    /**
     8.1 Update the `scoreLabel`'s text to be the `score`. - DONE
     */
    func updateScoreLabel() {
        
        // As my scoreLabel is a UIlabel, i can tap into its text property and equal it to score however, score is an integer so I used teh String function to convert it into text
        scoreLabel.text = String(score)
        
    }
    
    /**
     9.1 Update the title of each button in the IBOutlet collection to be the random letter at the corresponding index in the `randomLetters` array.
     Hint: `UIButton`s have a `setTitle` function. - DONE
     */
    func updateLetterButtons() {
        // The for loop, loops through every buutton in the letterButtons Array starting from 0 up until theere is no more to count
        for index in 0..<letterButtons.count {
            // I had a diffult time underrstanding the line below so I am breaking it down so it can stick
            // Remeber what we did above - randomLetters was set to = generateRandomLetters(numLetters: 12). It will give us 12 random letters so we needed to capture the value by going throw the index of each while the code does its thing to generate those random number. Whe it does that, we capture the value each time and stire it into our constant we named "letter"
            let letter = randomLetters[index]
            // Finally, take the value of each index of our rgulat letterButtons UI collection array and swap it out with the value above that we captured from "letter = randomLetters[index]" for each interation using the .setTitle function and in parenthesis adding "letter" which again represents the value we got from the randomLetters[index].
            letterButtons[index].setTitle(letter, for: .normal)
        }
    }
}
