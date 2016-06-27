//
//  ViewController.swift
//  swift_dictionary
//
//  Created by xionghuanxin on 6/27/16.
//  Copyright © 2016 xionghuanxin. All rights reserved.
//

import UIKit
let apikey = "250d852f1aff733e80a8e2f5b7ad8c36"
let searchApi = "http://v.juhe.cn/xhzd/query"

class ViewController: UIViewController {
    lazy var textField : UITextField  = {
        let aField = UITextField(frame: CGRect(x: 0, y: 400, width: 375, height: 100))
        aField.backgroundColor = UIColor.grayColor()
        aField.delegate = self
        return aField
        
    }()
    
    lazy var label : UILabel = {
        let aLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 375, height: 300))
        aLabel.textAlignment = NSTextAlignment.Left
        aLabel.backgroundColor = UIColor.redColor()
        aLabel.numberOfLines = 0
        return aLabel
        
    }()
    
    lazy var indicatorVie : UIActivityIndicatorView = {
        let aIndicatorVie = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        aIndicatorVie.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        aIndicatorVie.center = CGPoint(x: CGRectGetMidX(self.view.bounds), y: 100)
        aIndicatorVie.hidesWhenStopped = true
        return aIndicatorVie
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(self.textField)
        self.view.addSubview(self.label)
        self.view.addSubview(self.indicatorVie)
    }
    
    func renderWord(word:protocol<WordType>) {
        label.text = "\(word.name) \n\(word.prounciation) \n\(word.difination) \n"
    }
    
    func dictionaryService(word : String){
        let searchUrl = "\(searchApi)?key=\(apikey)&word=\(word)"
        let uif8url = searchUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! as String
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(NSURL(string: uif8url)!){(data,response,error) in
            let json = JSON(data:data!)
            let wordName = json["result"]["zi"].string
            let wordPrunciation = json["result"]["pinyin"].string
            print(wordPrunciation)
            let wordDifinations = json["result"]["jijie"].array
            var wordDifination : String = ""
            for wordString in wordDifinations! {
                wordDifination += "\(wordString)\n"
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.indicatorVie.stopAnimating()
                let youdao = youDaoWord(name: wordName!, prounciation: wordPrunciation!, difination: wordDifination)
                self.renderWord(youdao)
            }

            }.resume()
    }
}



extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        self.textField.resignFirstResponder()
        self.indicatorVie.startAnimating()
        self.dictionaryService(textField.text!)
        return true
    }
    
}
