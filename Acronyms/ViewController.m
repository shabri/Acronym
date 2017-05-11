//
//  ViewController.m
//  Acronyms
//
//  Created by Shabarinath Pabba on 5/11/17.
//  Copyright © 2017 shabri. All rights reserved.
//

#import "ViewController.h"
#import "NSString+EmptySpaces.h"
#import "AcronymServiceManager.h"
#import "Meanings.h"
#import "LongForm.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *contentsTableView;
@property (nonatomic, strong) Meanings *meanings;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark class methods
-(void)searchMeaningFor:(NSString *)acronym{
    
    if ([acronym isJustSpaces]) {
        [self showNotValidAcronymError];
        return;
    }
    
    AcronymServiceManager *serviceManager = [AcronymServiceManager sharedInstance];
    [serviceManager getMeaningsFor:acronym success:^(Meanings *meanings) {
        
        self.meanings = meanings;
        
        if (meanings.list.count > 0) {
            [self.contentsTableView reloadData];
        }else{
            NSString *errorMessage = @"There is no meaning for what you typed, please choose a different word";
            [self showAlertWithMessage:errorMessage];
        }
        
    } failure:^(NSError *error) {
        
        if (error.code == 10005 || error.code == 10006) {
            [self showAlertWithMessage:error.description];
        }else{
            NSString *errorMessage = @"Your search did not return any results, try looking for a different word or your connection might be down";
            [self showAlertWithMessage:errorMessage];
        }
        
    }];
    
}

-(void)showNotValidAcronymError{
    //Show an alert message for when its just empty spaces
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Error" message:@"C'mon thats not even a word its only empty spaces try a better Acronym :D" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:okAction];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
}

-(void)showAlertWithMessage:(NSString *)errorMessage{
    
    //Show an alert message for when the search was successful but nothing was shown
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:okAction];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}
#pragma mark UITableView DataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.meanings.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    
    LongForm *lf = [self.meanings.list objectAtIndex:indexPath.row];
    cell.textLabel.text = lf.LFString;
    
    return cell;
    
}

#pragma mark UISearchBar delegates
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self searchMeaningFor:searchBar.text];
}

@end
