//
//  ViewController.swift
//  PhotoGallery
//
//  Created by 双泉 朱 on 17/1/9.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    fileprivate lazy var webView: UIWebView = {[weak self] in
        let webView = UIWebView()
        webView.delegate = self
        webView.frame = CGRect(x: 0,
                               y: 0,
                               width:  kScreenW,
                               height: kScreenH)
        return webView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebView()
    }
}

extension ViewController {
    
    fileprivate func setupWebView() {
        view.addSubview(webView)
    }
}

extension ViewController {
    
    fileprivate func loadWebView() {
        guard let file = Bundle.main.path(forResource: "index", ofType: "html") else { return }
        guard let htmlString = try? String(contentsOfFile: file, encoding: .utf8) else { return }
        let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
        webView.loadHTMLString(htmlString, baseURL: baseURL)
    }
}

extension ViewController {
    
    @objc fileprivate func openPhotoGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true)
        } else {
            print("access photo gallery error")
        }
    }
}

extension ViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let href = request.url?.absoluteString else { return false }
        if href.hasPrefix("ios") {
            guard let method = href.components(separatedBy: "://").last else { return false }
            let selector = Selector.init(method)
            if self.responds(to: selector) {
                self.perform(selector)
            }
            return false
        }
        return true
    }
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        guard let Document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
            else { return }
        let path = "\(Document)/\("image\(arc4random()%100).png")"
        if FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.removeItem(atPath: path)
        }
        try! UIImagePNGRepresentation(image!)?.write(to: URL(fileURLWithPath: path))
        picker.dismiss(animated: true) {
            self.webView.stringByEvaluatingJavaScript(from: "loadImageWithPath('\(path)');")
        }
    }
}

