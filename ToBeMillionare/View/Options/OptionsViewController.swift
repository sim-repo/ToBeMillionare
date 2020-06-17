import UIKit


class OptionsViewController: UIViewController {
    
    @IBOutlet weak var gameModeTextField: UITextField!
    @IBOutlet weak var gameModePickerView: UIPickerView!
    @IBOutlet weak var usePassedQuestionsSwitch: UISwitch!
    
    var presenter: ViewableOptionsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        setOutlets()
    }
    
    private func setOutlets(){
        gameModeTextField.delegate = self
        gameModePickerView.isHidden = true
    }
    
    private func setPresenter() {
        let p: OptionsPresenter  = PresenterFactory.shared.getPresenter(viewDidLoad: self) as! OptionsPresenter
        presenter = p as ViewableOptionsPresenter
    }
    
    @IBAction func pressBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressSwitch(_ sender: UISwitch) {
        presenter.didSetUsePassedQuestions(enabled: sender.isOn)
    }
}



//MARK:- UIPicker Delegate
extension OptionsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameModeTextField.text = GameModeEnum.allCases[row].rawValue
        gameModePickerView.isHidden = true
        presenter.didSelectMode(modeEnum: GameModeEnum.allCases[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: GameModeEnum.allCases[row].rawValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}


//MARK:- Text Field Delegate
extension OptionsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.gameModeTextField {
            gameModePickerView.isHidden = false
            textField.endEditing(true)
        }
    }
}

//MARK:- Presentable

extension OptionsViewController: PresentableOptionsView {
    
    func setGameMode(modeEnum: GameModeEnum) {
        gameModeTextField.text = modeEnum.rawValue
    }
    
    func setUsePassedQuestions(enabled: Bool) {
        usePassedQuestionsSwitch.isOn = enabled
    }
}
