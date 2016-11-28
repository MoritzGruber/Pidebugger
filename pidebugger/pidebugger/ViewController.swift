//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var right: UIStackView!
    @IBOutlet weak var left: UIStackView!
    let pi = raspberrypi.init()
    //print("              PI:  \( pi.pins[1])");
    
    
    //2 variables to temporary store data from the TriStateButton class before adding it to the pinValue Array
    var buttonTag: Int!
    var buttonState: String!
    
    
    var screenwidth : CGFloat!
    var screenheight : CGFloat!
    
    
    var imageView : UIImageView!
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    
    let durationFadeIn = 6
    
    var currentPin = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBackground()
        //socketService.connect();
        
        //sshService.start();
    
        screenwidth = self.view.frame.size.width
        screenheight = self.view.frame.size.height
        print("\(screenwidth) ,\(screenheight)")
        
        
        
        let screenWidthInPixels = UIScreen.main.nativeBounds.width;
        let screenHeightInPixels = UIScreen.main.nativeBounds.height;
        print(screenWidthInPixels);
        print(screenHeightInPixels);
        
        
        
        let spacingTop = 30;
        let spacingBot = 50;
        let oneButtonSpace = (Int(screenheight!) - (spacingTop + spacingBot))/20;
                print(oneButtonSpace);
        var yHeight = spacingTop;
        let xFirstRow = (Int(screenwidth) - 4 * oneButtonSpace);
        let xSecRow = (Int(screenwidth) - 2 * oneButtonSpace);
        print(xFirstRow);
        print(xSecRow);
        // Do any additional setup after loading the view, typically from a nib.
    
        
        super.viewDidLoad()
        
        
        for index in 1...20 {
            let button = TriStateButton(frame: CGRect(x: xFirstRow, y: (Int(yHeight)), width: Int(oneButtonSpace)-2, height: Int(oneButtonSpace)-2), indexTag:(index * 2 ) - 1, piObject: pi);
            //button.setTitle("x", for: .normal);
            //button.backgroundColor = UIColor.blue;
            //self.view.addSubview(button)
            
            button.alpha = 0
            button.fadeIn(duration: TimeInterval(Int(durationFadeIn)), delay: 0)
            
                print(yHeight);
                self.view.addSubview(button);
            yHeight += Int(oneButtonSpace);
            
        }
        yHeight = spacingTop;
        for index in 1...20 {
            
            let button = TriStateButton(frame: CGRect(x:xSecRow, y: (Int(yHeight)), width: Int(oneButtonSpace)-2, height: Int(oneButtonSpace)-2), indexTag: (index * 2), piObject: pi);
            //button.setTitle("y", for: .normal);
            //button.backgroundColor = UIColor.blue;
            //self.view.addSubview(button)
            
            button.alpha = 0
            button.fadeIn(duration: TimeInterval(Int(durationFadeIn)), delay: 0)
            
            print(yHeight);
            self.view.addSubview(button);
            yHeight += Int(oneButtonSpace);
            
        }
        
        yHeight = spacingTop;
        for index in 1...5 {
            let button = TriStateButton(frame: CGRect(x: 10, y: (Int(yHeight)), width: Int(((oneButtonSpace)-2)/2), height: Int(((oneButtonSpace)-2))/2), indexTag: 0, piObject: pi);
            //button.setTitle("x", for: .normal);
            //button.backgroundColor = UIColor.blue;
            //self.view.addSubview(button)
        
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
    

    
    
    /*
    let duration = 0.5
    
    func fadeIn(finished: Bool) {
        UIView.animateWithDuration(self.duration, delay: 0, options: [.CurveEaseInOut], animations: { self.view.alpha = 1 } , completion: self.fadeOut)
    }
        */
 

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 3.0, animations: { self.blurEffectView.alpha = 1.0; return })
        
        //self.button.fadeIn(duration: 3, delay: 0)
        
        //TriStateButton.animate(withDuration: 3.0, animations: { .alpha = 1.0; return })
        
    }
 
    
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //Storing the current Pin state of a Button in the pinValue Array (Button tag - 1 = corresponding index in the Array)
    @IBAction func getButtonTag(_ sender: TriStateButton) {
    
        buttonTag = (sender.indexTag)
        buttonState = sender.pinState[sender.currentPinState]
        
        pi.pins[buttonTag] = buttonState
        
        setPinValues()
    }
    
    
    //Test function to see if pinValue Array values are set properly
    func setPinValues(){
        
        print(buttonTag)
        print(buttonState)
        print(pi.pins)
    }
    
    
    func addBackground(){
        
        let backgroundImage = UIImage(named: "raspi_background")
        let launchImage = UIImage(named: "raspi_launch")
        
        //var imageView : UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        
        //imageView.alpha = 0
        
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        //let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurEffectView.alpha = 0

        view.addSubview(imageView)
        view.addSubview(blurEffectView)
        
        self.view.sendSubview(toBack: imageView)
    }
    
    
 
}

