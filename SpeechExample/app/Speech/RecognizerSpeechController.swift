//
//  RecognizerSpeechController.swift
//  SpeechExample
//
//  Created by ablett on 2019/7/12.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class RecognizerSpeechController: ViewController {

    // 提示
    fileprivate lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = recognizer_prompt_text
        label.fontSize = 14
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        return label
    }()
    
    // 输入框
    fileprivate lazy var textView: UITextView = {
        let view = UITextView()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.darkGray
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.2);
        view.isEditable = false
        return view
    }()
    
    // 合成按钮
    fileprivate lazy var recognizerButton: UIButton = {
        let darkColor = UIColor.init(argb: 0xffff3333)
        let lightColor = UIColor.init(argb: 0xff009933)
        let button = UIButton.init(type: .custom)
        button.setTitle("开始识别", for: .normal)
        button.setTitle("取消识别", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setBackgroundImage(UIImage.image(with: lightColor, size: CGSize.init(width: 100.0, height: 50)), for: .normal)
        button.setBackgroundImage(UIImage.image(with: darkColor, size: CGSize.init(width: 100.0, height: 50)), for: .selected)
        button.fontSize = 16
        button.addTarget(self, action: #selector(recognizerAction(_:)), for: .touchUpInside)
        return button
    }()

    override public func prepare() {
        super.prepare()
        prepareViews()
        
        // 权限检测
        permissionDetection()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancelRecognizer(recognizerButton)
    }
    
    // UI
    func prepareViews() -> Void {
        
        view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(15)
            make.height.equalTo(30)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(promptLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(200)
        }
        
        view.addSubview(recognizerButton)
        recognizerButton.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.left.right.equalTo(textView)
            make.height.equalTo(35)
        }
    }
    
    // 识别按钮点击事件
    @objc func recognizerAction(_ sender: UIButton) -> Void {
        if sender.isSelected {
            cancelRecognizer(sender)
        }else {
            startRecognizer(sender)
        }
        sender.isSelected = !sender.isSelected
    }
 
    // 权限检测
    func permissionDetection() -> Void {
        microphonePermissionDetection()
    }
    
    // 麦克风权限检测
    func microphonePermissionDetection() -> Void {
        let p = MicrophonePermission()
        if p.isDenied {
            let alert = UIAlertController.init(title: "权限被拒", message: "请到设置里面打开语音识别权限", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction.init(title: "去设置", style: .default, handler: { (action) in
                UIApplication.shared.open(
                    URL.init(string: UIApplication.openSettingsURLString)!
                )
            }))
            self.present(alert, animated: true) {}
        }
        
        if p.isAuthorized {
            speechPermisstionDetection()
        }
        
        if p.isDenied == false {
            p.request {
                self.microphonePermissionDetection()
            }
        }
    }
    
    // 语音识别权限检测
    func speechPermisstionDetection() -> Void {
        let p = SpeechPermission()
        if p.isDenied {
            let alert = UIAlertController.init(title: "权限被拒", message: "请到设置里面打开语音识别权限", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction.init(title: "去设置", style: .default, handler: { (action) in
                UIApplication.shared.open(
                    URL.init(string: UIApplication.openSettingsURLString)!
                )
            }))
            self.present(alert, animated: true) {}
        }
        
        if p.isDenied == false {
            p.request {
                self.speechPermisstionDetection()
            }
        }
    }
    
    // 识别相关
    
    fileprivate var recognitionTask: SFSpeechRecognitionTask?
    
    fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    fileprivate lazy var recognizer: SFSpeechRecognizer = {
        let r = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
        r?.delegate = self
        return r!
    }()
    
    fileprivate let audioEngine = AVAudioEngine()    
}

extension RecognizerSpeechController {
    
    // 开始识别
    @objc fileprivate func startRecognizer(_ sender: UIButton) -> Void {
        cancelRecognizer(sender)
        
        // 获取音频会话
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.record)
            try session.setMode(.measurement)
        } catch {
            print("Throws：\(error)")
        }
        
        // 创建识别请求
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        textView.text = ""
        
        let inputNode = audioEngine.inputNode
        
        // 开始识别
        recognitionTask = recognizer.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in
            if result == nil { return }
            var text = ""
            for obj in result!.transcriptions{
                text += obj.formattedString
            }
            self.textView.text = text
            self.textView.scrollRangeToVisible(NSMakeRange(self.textView.text.count, 1))
            
            if result!.isFinal{
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        })
        
        let recordFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordFormat, block: { (buffer, time) in
            self.recognitionRequest?.append(buffer)
        })
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Throws：\(error)")
        }
    }
    
    // 取消识别
    @objc fileprivate func cancelRecognizer(_ sender: UIButton) -> Void {
        if recognitionTask != nil{
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        removeTask()
    }
    
    //销毁录音任务
    fileprivate func removeTask(){
        self.audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        self.recognitionRequest = nil
        self.recognitionTask = nil
    }
}

extension RecognizerSpeechController: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        recognizerButton.isEnabled = available
    }
}
