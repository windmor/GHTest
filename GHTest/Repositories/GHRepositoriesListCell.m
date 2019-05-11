//
//  GHRepositoriesListCell.m
//  GHTest
//
//  Created by Liliya Sayfutdinova on 10/05/2019.
//  Copyright © 2019 Liliya Sayfutdinova. All rights reserved.
//

#import "GHRepositoriesListCell.h"

#import "GHRepository.h"

@interface GHRepositoriesListCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblLang;
@property (weak, nonatomic) IBOutlet UILabel *lblOwner;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end

@implementation GHRepositoriesListCell

- (void)fillWithData:(GHRepository *)repository
{
    self.lblName.text = repository.name;
    self.lblLang.text = repository.language;
    self.lblOwner.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Owner", nil), repository.owner.login];
    self.lblDesc.text = repository.descriptionText;
    
    [self.lblName sizeToFit];
    [self.lblDesc sizeToFit];
}

+ (NSString *)cellID
{
    return NSStringFromClass([self class]);
}

@end
