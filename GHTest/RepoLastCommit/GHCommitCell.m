//
//  GHCommitCell.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 12/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHCommitCell.h"

#import "GHCommit.h"

#import <SDWebImage/SDWebImage.h>

@interface GHCommitCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSha;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *imgAuthor;

@end

@implementation GHCommitCell

- (void)fillWithData:(GHCommit *)commit
{
    self.lblTitle.text = commit.message;
    self.lblSha.text = commit.sha;
    self.lblAuthor.text = commit.author.name;
    
    self.imgAuthor.image = nil;
    if (commit.author && commit.author.avatarUrl) {
        [self.imgAuthor sd_setImageWithURL:commit.author.avatarUrl];
    }
    
    [self.lblTitle sizeToFit];
}

+ (NSString *)cellID
{
    return NSStringFromClass([self class]);
}

@end
