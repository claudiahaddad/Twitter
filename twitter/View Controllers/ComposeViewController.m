//
//  ComposeViewController.m
//  twitter
//
//  Created by Claudia Haddad on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ComposeViewController
- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    // Do any additional setup after loading the view.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

int characterLimit = 140;
    
NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];

    self.countLabel.text = [NSString stringWithFormat:@"%d", 140 - [newText length]];


// The new text should be allowed? True/False
return newText.length < characterLimit;

}
- (IBAction)tweetAction:(id)sender {
    NSString *tweetString = self.textView.text;
    [[APIManager shared] postStatusWithText:tweetString completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");

            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"ERROR: %@", error);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
