//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by Hossam Ghareeb on 11/15/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
let imageURLs = ["https://scontent.fsgn5-1.fna.fbcdn.net/v/t31.0-8/s960x960/16487674_1305034889554168_9144538363083515071_o.jpg?oh=a132e1e85f8b95c54673ae603d3f5b31&oe=59799F04",
                 "https://scontent.fsgn5-1.fna.fbcdn.net/v/t1.0-9/18423839_1248238848607318_2433214752086205979_n.jpg?oh=31716e276d61b34b1e623cd244a4d726&oe=59AC899F",
                 "https://scontent.fsgn5-1.fna.fbcdn.net/v/t1.0-9/18423839_1248238848607318_2433214752086205979_n.jpg?oh=31716e276d61b34b1e623cd244a4d726&oe=59AC899F",
                 "https://scontent.fsgn5-1.fna.fbcdn.net/v/t1.0-9/18423839_1248238848607318_2433214752086205979_n.jpg?oh=31716e276d61b34b1e623cd244a4d726&oe=59AC899F"]


class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    var quue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickOnStart(_ sender: AnyObject) {
        var queue = OperationQueue()
        
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL(self.imageURLs[0]);
            OperationQueue.main.addOperation {
                self.imageView1.image = img1
            }
        })
        operation1.completionBlock = {
            operation1.completionBlock = {
                print("Operation 1 completed, cancelled: \(operation1.isCancelled)")
            }
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            let img2 = Downloader.downloadImageWithURL(self.imageURLs[1]);
            OperationQueue.main.addOperation {
                self.imageView2.image = img2
            }
        })
        operation2.completionBlock = {
            operation2.completionBlock = {
                print("Operation 2 completed, cancelled: \(operation2.isCancelled)")
            }
        }
        queue.addOperation(operation2)

        
        let operation3 = BlockOperation(block: {
            let img3 = Downloader.downloadImageWithURL(self.imageURLs[2]);
            OperationQueue.main.addOperation {
                self.imageView3.image = img3
            }
        })
        operation3.completionBlock = {
            operation3.completionBlock = {
                print("Operation 3 completed, cancelled: \(operation3.isCancelled)")
            }
        }
        queue.addOperation(operation3)

        
        let operation4 = BlockOperation(block: {
            let img4 = Downloader.downloadImageWithURL(self.imageURLs[3]);
            OperationQueue.main.addOperation {
                self.imageView4.image = img4
            }
        })
        operation4.completionBlock = {
            operation4.completionBlock = {
                print("Operation 4 completed, cancelled: \(operation4.isCancelled)")
            }
        }
        queue.addOperation(operation4)
        
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)

        
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }

}

