//
//  MainTableViewController.m
//  QMHex
//
//  Created by Lin on 15/5/9.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

#import "MainTableViewController.h"
#import "Common.h"
#import "KeyboardView.h"
@implementation MainTableViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _binTextField.leftLabel.text = @"BIN  ：";
    _octTextField.leftLabel.text = @"OCT ：";
    _decTextField.leftLabel.text = @"DEC ：";
    _hexTextField.leftLabel.text = @"HEX ：";
    
    _currentTextField.leftLabel.text = @"BIN  ：";
//    _originalTextField.leftLabel.text = @"TURECODE：";
//    _counterTextField.leftLabel.text = @"COMPLEMENTAL CODE：";
//    _fillTextField.leftLabel.text = @"ONES-COMPLEMENT CODE：";
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 30;
//    }
//    
//    return 20;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == _binTextField ) {
        [((KeyboardView *)textField.inputView) setType:INT_BIN];
    }
    else if (textField == _octTextField){
        [((KeyboardView *)textField.inputView) setType:INT_OCT];
    }
    else if (textField == _decTextField){
        [((KeyboardView *)textField.inputView) setType:INT_DEC];
    }
    else if (textField == _hexTextField){
        [((KeyboardView *)textField.inputView) setType:INT_HEX];
    }
    else if (textField == _currentTextField) {
        [((KeyboardView *)textField.inputView) setType:INT_ORI];
    }
    
    [((KeyboardView *)textField.inputView) decimalPoint];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self changeTextField:textField];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _currentTextField &&  textField.text.length >= [GUserDefault digit]-1) {
        
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"设置是%ld进制",(long)[GUserDefault digit]]
                                  maskType:SVProgressHUDMaskTypeBlack];
        
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self changeTextField:textField];
    [self.view endEditing:YES];
    return YES;
}

- (void)changeTextField:(UITextField *)textField {
    if (textField == _binTextField) {
        _octTextField.text = [Common OctFromBin:textField.text];
        _decTextField.text = [Common DecFromBin:textField.text];
        _hexTextField.text = [Common HexFromBin:textField.text];
    }
    else if (textField == _octTextField){
        _binTextField.text = [Common BinFromOct:textField.text];
        _decTextField.text = [Common DecFromOct:textField.text];
        _hexTextField.text = [Common HexFromOct:textField.text];
    }
    else if (textField == _decTextField){
        _binTextField.text = [Common BinFromDec:textField.text];
        _octTextField.text = [Common OctFromDec:textField.text];
        _hexTextField.text = [Common HexFromDec:textField.text];
    }
    else if (textField == _hexTextField){
        _binTextField.text = [Common BinFromHex:textField.text];
        _octTextField.text = [Common OctFromHex:textField.text];
        _decTextField.text = [Common DecFromHex:textField.text];
    }
    else if (textField == _currentTextField) {
        _tureLabel.text = [Common OriginalFromBin:textField.text];
        _onecomLabel.text = [Common CounterFromBin:textField.text];
        _comLabel.text = [Common FillFromBin:textField.text];
    }
    
    
    
}
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    
//    if (_binTextField.editing) {
//        [self changeTextField:_binTextField];
//    }else if (_octTextField.editing){
//        [self changeTextField:_octTextField];
//    }else if (_decTextField.editing){
//        [self changeTextField:_decTextField];
//    }else if (_hexTextField.editing){
//        [self changeTextField:_hexTextField];
//    }
//    
//    [self.view endEditing:YES];
//}

@end
