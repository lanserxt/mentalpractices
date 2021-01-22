//
//  PracticeViewController.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit


/// Class to work with Practice
final class PracticeViewController: ViewController, MainCoordinated {
    var coordinator: MainCoordinator?
    
    /// Practise to show
    var practice: Practice?
    
    
    
    @IBOutlet private(set) weak var titleLbl: UILabel!
    @IBOutlet private(set) weak var subTitleLbl: UILabel!
    @IBOutlet private(set) weak var logoView: UIImageView! {
        didSet{
            logoView.backgroundColor = .clear
            logoView.image = UIImage(named: "placeholder")
        }
    }
    @IBOutlet weak var restartButton: UIBarButtonItem! {
        didSet {
            restartButton.title = NSLocalizedString("Restart", comment: "")
        }
    }
    let viewModel = PracticeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadPractice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    private func loadPractice() {
        guard let practice = practice else {return}
        titleLbl.text = practice.title
        subTitleLbl.text = practice.subtitle
        
        //Loading cover
        if let iconUrl = practice.icon.loadURL {
           logoView.loadUrl(iconUrl)
        }
        
        //Loading audio
        if let audioUrl = practice.audio.loadURL {
            viewModel.prepareAudioSession(audioUrl)
        }
    }
    
    
    
    //MARK:- Media actions
    
    
    @IBAction func play(_ sender: Any) {
        viewModel.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        viewModel.pause()
    }
    
    @IBAction func restart(_ sender: Any) {
        viewModel.restart()
    }
    
}
