//
//  BELBonjourServer.h
//  posIntegrationExample
//
//  Created by Sean Wolter on 9/28/15.
//  Copyright © 2015 Belly. All rights reserved.
//

#import "DTBonjourServer.h"

@interface BELBonjourServer : DTBonjourServer

- (instancetype)initWithDisplayCode:(NSString *)displayCode;

- (BOOL)sendPayload:(NSDictionary *)payload;

@end
