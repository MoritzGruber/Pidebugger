//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit


class ViewControllerMain: UIViewController {
    
    @IBOutlet weak var right: UIStackView!
    @IBOutlet weak var left: UIStackView!
    let pi = raspberrypi.init()
   
    var screenwidth : CGFloat!
    var screenheight : CGFloat!
    
    // Views for background image and blur effect
    var imageView : UIImageView!
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    // Time it takes until buttons and description legend will appear (fade-in)
    let durationFadeIn = Double(6.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Loading the background design of the ViewController
        addBackground()        
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Fading the blur effect for background and creating & fading the buttons after viewDidLoad is done
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let socket = socketService.init()
        
        // fading the blur effect for background
        UIView.animate(withDuration: 3.0, animations: { self.blurEffectView.alpha = 1.0; return })
        
        
        // Get Screensize
        screenwidth = self.view.frame.size.width
        screenheight = self.view.frame.size.height
        
        // Calculate variables for rendering buttons later
        let spacingTop = 30;
        let spacingBot = 50;
        let oneButtonSpace = (Int(screenheight!) - (spacingTop + spacingBot))/20;
        var yHeight = spacingTop;
        let xFirstRow = (Int(screenwidth) - 4 * oneButtonSpace);
        let xSecRow = (Int(screenwidth) - 2 * oneButtonSpace);
        
        
        //define function to gerate a responive row of buttons
        func generateRow(x: Int, indexOffset: Int){
            //reset top start point
            yHeight = spacingTop;
            for index in 1...20 {
                //create button with the right index to call him later by his index
                let button = TriStateButton(frame: CGRect(x: x, y: (Int(yHeight)), width: Int(oneButtonSpace)-2, height: Int(oneButtonSpace)-2), buttonTag: (index * 2) + indexOffset, piObject: pi, socket: socket);
                //set attributes
                button.alpha = 0
                button.fadeIn(duration: durationFadeIn, delay: 0.0)
                
                //add to view
                self.view.addSubview(button);
                yHeight += Int(oneButtonSpace);
            }
        }
        
        //create the left Row of buttons
        generateRow(x: xFirstRow, indexOffset: -1)
        //create the right Row of buttons
        generateRow(x: xSecRow, indexOffset: 0)
        
        
        // Create buttons for the legend on the left side
        yHeight = spacingTop;
        for index in 1...5 {
            let button = TriStateButton(frame: CGRect(x: 10, y: (Int(yHeight)), width: Int(((oneButtonSpace)-2)/2), height: Int(((oneButtonSpace)-2))/2), buttonTag: 0, piObject: pi, socket: socket);
        
            button.alpha = 0
            button.fadeIn(duration: durationFadeIn, delay: 0.0)
            
            switch index {
            case 1: button.backgroundColor = UIColor.green;
            case 2: button.backgroundColor = UIColor.orange;
            case 3: button.backgroundColor = UIColor.red;
            case 4: button.backgroundColor = UIColor.black;
            case 5: button.backgroundColor = UIColor.gray;
            default: print("wrong index value");
            }
            
            self.view.addSubview(button);
            yHeight += Int(oneButtonSpace);
        }
        
        // Create labels for the legend on the left side
        let xLabel = 10 + oneButtonSpace;
        yHeight = spacingTop;
        for index in 1...5 {
            let label = UILabel(frame: CGRect(x: xLabel, y: (Int(yHeight)), width: 200, height: Int(((oneButtonSpace)-2))/2));
            
            label.alpha = 0
            label.fadeIn(duration: durationFadeIn, delay: 0.0)
            
            label.textAlignment = .left
            label.font = UIFont(name: "Helvetica", size: CGFloat(Int(oneButtonSpace/4)));
            
            switch index {
            case 1: label.text = "Active Pins (l = low, h = high, i = input)";
            case 2: label.text = "3,3V Pins (inactive)";
            case 3: label.text = "5V Pins (inactive)";
            case 4: label.text = "Ground Pins (inactive)";
            case 5: label.text = "ID Pins (inactive)";
            default: print("wrong index value");
            }
            
            self.view.addSubview(label);
            yHeight += Int(oneButtonSpace);
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // Creating the background design for the ViewController
    func addBackground(){
        
        // Setting the background image
        let backgroundImage = UIImage(named: "raspi_background")
        
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center

        // Adding a blur effect to the background image
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0

        view.addSubview(imageView)
        view.addSubview(blurEffectView)
        
        self.view.sendSubview(toBack: imageView)
    }
    
 
}

