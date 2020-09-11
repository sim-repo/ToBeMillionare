//
//  BetViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 25.07.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class BetViewController: UIViewController {
    
    
    @IBOutlet weak var betView: PlayBetView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerButton: UIButton!
    
    
    private lazy var depo: Double = presenter.getDepo()
    private var isSetBet = false
    
    private var presenter: ReadablePlayPresenter & WritablePlayPresenter {
        let presenter: PlayPresenter = PresenterFactory.shared.getInstance()
        return presenter as ReadablePlayPresenter & WritablePlayPresenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.isHidden = true
        let betSum = depo <= presenter.getMinBetSum() ? depo : 0
        betView.setup(actualMoneyEnum: presenter.getActualCurrency(), betAim: presenter.getStageAim(), betDepo: CGFloat(depo), betRecovery: presenter.getZondRecovery(), betSum: betSum)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        betView.start()
    }
    
    @IBAction func pressPickerButton(_ sender: Any) {
        if presenter.canSelectBet() {
            picker.isHidden = false
            pickerButton.isHidden = true
        }
    }
    
    @IBAction func pressPlay(_ sender: Any) {
        guard isSetBet
            else {
                betView.tip()
                return
        }
        performSegue(withIdentifier: "seguePlay", sender: nil)
    }
}



//MARK:- UIPicker Delegate
extension BetViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.setBetPercentOfDepo(betPercentOfDepo: Double((row + 1) * 10))
        isSetBet = true
        let betSum = presenter.getBetSum()
        let fireproof = presenter.getFireproofRound(nil)
        let minAward = presenter.getMinAward()
        betView.update(betSum: betSum, minAward: minAward, fireproofRound: fireproof)
        picker.isHidden = true
        pickerButton.isHidden = false
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: "\(((row+1)*10))%", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}
