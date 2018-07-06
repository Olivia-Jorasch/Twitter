//
//  ComposeViewController.m
//  twitter
//
//  Created by Olivia Jorasch on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
- (IBAction)closeButton:(id)sender;
- (IBAction)tweetButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetText.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range 
replacementString:(NSString *)string {
    int charLimit = 140;
    NSString *newText = [self.tweetText.text stringByReplacingCharactersInRange:range withString:string];
    return newText.length < charLimit;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetButton:(id)sender {
    NSString *text = self.tweetText.text;
    [[APIManager shared] postStatusWithText:text completion:^(Tweet * tweet, NSError * error) {
        
        if (tweet) {
            NSLog(@"😎😎😎 good work!");
            [self.delegate didTweet:tweet];

            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
