//
//  NewInteractionViewController.swift
//  CVDTracer
//
//  Created by Segundo Fariña on 26/08/2020.
//

import UIKit
import AndesUI

public class NewInteractionViewController: UIViewController {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var dateTextField: AndesTextField!
    @IBOutlet weak var locationTextField: AndesTextField!
    @IBOutlet weak var participantsTextField: AndesTextField!
    
    private var datePicker: UIDatePicker!
    
    public override func loadView() {
        let bundle = Bundle(for: type(of: self))
        let className = type(of: self).description().components(separatedBy: ".").last
        
        if let nibName = className, let nib = bundle.loadNibNamed(nibName, owner: self), let nibView = nib.first as? UIView {
            self.view = nibView
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = AndesStyleSheetManager.styleSheet.bgColorPrimary
        self.setUpDatePicker()
        self.setUpTextFields()
        
        // Gesture recognizer for dismissing the keyboard on screen tap
        let gestureRecongizer = UITapGestureRecognizer(target: self, action: #selector(doneDatePicker))
        self.view.addGestureRecognizer(gestureRecongizer)
    }
    
    private func setUpTextFields () {
        headerTitle.textColor = AndesStyleSheetManager.styleSheet.textColorPrimary
        headerTitle.font = AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 24)
        
        subtitle.textColor = AndesStyleSheetManager.styleSheet.textColorPrimary
        subtitle.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16)
        subtitle.text = "Te recomendamos realizar un test en cuanto sientas algun sintoma."
        
        dateTextField.label = "Fecha"
        dateTextField.leftContent = AndesTextFieldComponentIcon(andesIconName: "andes_otros_almanaque_20", tintColor: AndesStyleSheetManager.styleSheet.accentColor600)
        dateTextField.text = formatDate(date: Date())
        
        locationTextField.label = "Lugar"
        locationTextField.placeholder = "¿Con quien te juntaste?"
        locationTextField.leftContent = AndesTextFieldComponentIcon(andesIconName: "andes_control_y_accion_buscar_20", tintColor: AndesStyleSheetManager.styleSheet.accentColor600)
        
        participantsTextField.label = "Participantes"
        participantsTextField.placeholder = "Agregar un participante"
        participantsTextField.leftContent = AndesTextFieldComponentIcon(andesIconName: "andes_control_y_accion_buscar_20", tintColor: AndesStyleSheetManager.styleSheet.accentColor600)
    }
    
    func setUpDatePicker() {
        self.datePicker = UIDatePicker()
        
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "es-ar")
        dateTextField.inputView = datePicker
    }

     @objc func doneDatePicker() {
        dateTextField.text = formatDate(date: datePicker.date)
        self.view.endEditing(true)
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}
