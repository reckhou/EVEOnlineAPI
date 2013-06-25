//
//  EVEAccountStatus.h
//  EVEOnlineAPI
//
//  Created by Artem Shimanski on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVERequest.h"

@interface EVEAccountStatus : EVERequest
@property (nonatomic, strong) NSDate *paidUntil;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic) NSInteger logonCount;
@property (nonatomic) NSInteger logonMinutes;

+ (id) accountStatusWithKeyID: (NSInteger) keyID vCode: (NSString*) vCode error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress)) progressHandler;
- (id) initWithKeyID: (NSInteger) keyID vCode: (NSString*) vCode error:(NSError **)errorPtr progressHandler:(void(^)(CGFloat progress)) progressHandler;


@end
