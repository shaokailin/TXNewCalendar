//
//  TXXLFestivalsProtocol.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TXXLFestivalsProtocol <NSObject>
@optional
- (void)loadError;
- (void)loadSucess:(id)data;
- (void)selectCurrentView;
@end
