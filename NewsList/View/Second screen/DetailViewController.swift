//
//  DetailViewController.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit
import Speech

class DetailViewController: UIViewController {

    var viewModel: DetailScreenViewModelType?
    
    private var synth: AVSpeechSynthesizer!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UITextView!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var listenButton: ListenButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = viewModel else { return }
        self.articleTitle.text = model.articleTitle
        self.articleDescription.text = model.articleDescription
        self.publishedLabel.text = model.articlePublished
        self.urlLabel.text = model.articleURL
        model.articleImage.bind { [unowned self] in
            guard let image = $0 else { return }
            self.articleImage.image = image
        }
        
        synth = AVSpeechSynthesizer()
    }
    
    @IBAction func bacButtonAction(_ sender: BackButton) {
        synth.stopSpeaking(at: .immediate)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func listenAction(_ sender: ListenButton) {
        if synth.isPaused {
            listenButton.setTitle("Pause", for: .normal)
            synth.continueSpeaking()
        } else {
            if synth.isSpeaking {
                listenButton.setTitle("Resume", for: .normal)
                synth.pauseSpeaking(at: .word)
            } else {
                listenButton.setTitle("Pause", for: .normal)
                guard let textForSpeech = articleDescription.text else { return }
                let utterence = AVSpeechUtterance(string: textForSpeech)
                
                utterence.voice = AVSpeechSynthesisVoice(language: "ru-RU")
                synth.speak(utterence)
            }
        }
    }

}
