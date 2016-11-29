//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit
import LANScanner


class ViewController: UIViewController {
    
    @IBOutlet weak var right: UIStackView!
    @IBOutlet weak var left: UIStackView!
    let pi = raspberrypi.init(ip: "192.168.0.105")
    //print("              PI:  \( pi.pins[1])");
    
   
    var screenwidth : CGFloat!
    var screenheight : CGFloat!
    
    // Views for background image and blur effect
    var imageView : UIImageView!
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    // Time it takes until buttons and description legend will appear (fade-in)
    let durationFadeIn = 6
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let scannerDelegate = LANScanner().delegate;
        //let scanner = LANScanner(delegate: scannerDelegate! , continuous: false)
        //scanner.startScan()

        

        // Loading the background design to the ViewController
        addBackground()
        //scanService.init()
        //sshService.start(pi: pi)
  
        //socketService.init(pi: pi)
        
        //get Screensize
        screenwidth = self.view.frame.size.width
        screenheight = self.view.frame.size.height
        
        //calculate variables for rendering buttons later
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
                let button = TriStateButton(frame: CGRect(x: x, y: (Int(yHeight)), width: Int(oneButtonSpace)-2, height: Int(oneButtonSpace)-2), buttonTag: (index * 2) + indexOffset, piObject: pi);
                //set attributes
                button.alpha = 0
                button.fadeIn(duration: TimeInterval(Int(durationFadeIn)), delay: 0)

                //add to view
                self.view.addSubview(button);
            yHeight += Int(oneButtonSpace);
            }
            
        }

        //create the left Row of buttons
        generateRow(x: xFirstRow, indexOffset: -1)
        //create the right Row of buttons
        generateRow(x: xSecRow, indexOffset: 0)
            
        //create Elements for the legend on the left side
        yHeight = spacingTop;
        for index in 1...5 {
            
            let button = TriStateButton(frame: CGRect(x: 10, y: (Int(yHeight)), width: Int(((oneButtonSpace)-2)/2), height: Int(((oneButtonSpace)-2))/2), buttonTag: 0, piObject: pi);
        
            button.alpha = 0
            button.fadeIn(duration: TimeInterval(Int(durationFadeIn)), delay: 0)
            
            switch index {
            case 1: button.backgroundColor = UIColor.green;
            case 2: button.backgroundColor = UIColor.orange;
            case 3: button.backgroundColor = UIColor.red;
            case 4: button.backgroundColor = UIColor.black;
            case 5: button.backgroundColor = UIColor.gray;
            default: print("wrong index value");
            }
            
            print(yHeight);
            self.view.addSubview(button);
            yHeight += Int(oneButtonSpace);
        }
        
        // Creating the labels for the description legend
        let xLabel = 10 + oneButtonSpace;
        yHeight = spacingTop;
        for index in 1...5 {
            let label = UILabel(frame: CGRect(x: xLabel, y: (Int(yHeight)), width: 200, height: Int(((oneButtonSpace)-2))/2));
            
            label.alpha = 0
            label.fadeIn(duration: TimeInterval(Int(durationFadeIn)), delay: 0)
            
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
        
            print(yHeight);
            self.view.addSubview(label);
            yHeight += Int(oneButtonSpace);
        }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 3.0, animations: { self.blurEffectView.alpha = 1.0; return })
        
    }
 
    
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    
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

