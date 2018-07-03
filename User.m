//
//  User.m
//  twitter
//
//  Created by Claudia Haddad on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        
        NSString *URL = dictionary[@"profile_image_url"];
        
        self.picURL = [NSURL URLWithString:URL];

      //  TweetCell.profilePic.image = nil;
     //   if (self.picURL != nil) {
      //      [TweetCell.profilePic setImageWithURL:self.picURL];
        

    }
    return self;
}

@end
