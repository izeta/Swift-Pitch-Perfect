//
//  PlaySoundsViewController.swift
//  Lengthy Voice
//
//  Created by Zeta on 7/8/15.
//  Copyright (c) 2015 Zeta. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var recordedAudio:RecordedAudio!
    var engine:AVAudioEngine! //Needs to be declared globally, otherwise pitch will not work
    var myAudioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var manager = NSFileManager.defaultManager();
        audioPlayer = AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true;
        engine = AVAudioEngine();
        myAudioFile = AVAudioFile(forReading: recordedAudio.filePathUrl, error: nil)
        
        //Hardcoded mp3 file
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var url = NSURL.fileURLWithPath(filePath)
//            audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
//            audioPlayer.enableRate = true;
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }

    @IBAction func fastAudio(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariableRate(rateValue:Float) {
        engine.stop()
        audioPlayer.stop()
        audioPlayer.rate = rateValue
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitchValue:Float) {
        var playerNode = AVAudioPlayerNode()
        var auTimePitch = AVAudioUnitTimePitch()
        
        audioPlayer.stop()
        engine.stop()
        engine.reset()
        
        auTimePitch.pitch = pitchValue // In cents. The default value is 1.0. The range of values is -2400 to 2400
        auTimePitch.rate = 1.0 //The default value is 1.0. The range of supported values is 1/32 to 32.0.
        engine.attachNode(playerNode)
        engine.attachNode(auTimePitch)
        engine.connect(playerNode, to: auTimePitch, format: nil)
        engine.connect(auTimePitch, to: engine.outputNode, format: nil)
        
        playerNode.scheduleFile(myAudioFile, atTime: nil, completionHandler: nil)
        engine.startAndReturnError(nil)
        playerNode.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        println("stop")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
