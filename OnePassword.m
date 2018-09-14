#import "OnePassword.h"
#import "OnePasswordExtension.h"

#import <React/RCTUtils.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <React/RCTUIManager.h>

#import <UIKit/UIKit.h>
#import "UIView+React.h"

@implementation UIView (Recurrence)

- (NSArray<UIView *> *)recurrenceAllSubviews
{
    NSMutableArray <UIView *> *all = @[].mutableCopy;
    void (^getSubViewsBlock)(UIView *current) = ^(UIView *current){

        for (UIView *sub in current.subviews) {

            if ([sub.nativeID  isEqual: @"OnePassword"]) {
                [all addObject:sub];
            }

            [all addObjectsFromArray:[sub recurrenceAllSubviews]];
        }
    };
    getSubViewsBlock(self);
    return [NSArray arrayWithArray:all];
}
@end


@implementation OnePassword

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(isSupported: (RCTResponseSenderBlock)callback)
{
    if ([[OnePasswordExtension sharedExtension] isAppExtensionAvailable]) {
        callback(@[[NSNull null], @true]);
    }
    else {
        callback(@[RCTMakeError(@"OnePassword is not supported.", nil, nil)]);
        return;
    }
}

RCT_EXPORT_METHOD(findLogin: (NSString *)url
                  callback: (RCTResponseSenderBlock)callback)
{
    UIViewController *controller = RCTPresentedViewController();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *sender = nil;

        // Loop through all subviews to find a view with nativeID "OnePassword"
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        for(UIView *subview in keyWindow.subviews)
        {
            for (UIView *subsubview in [subview recurrenceAllSubviews])
            {
                sender = subsubview;
            }
        }
        
        [[OnePasswordExtension sharedExtension] findLoginForURLString:url
        forViewController:controller sender:sender completion:^(NSDictionary *loginDictionary, NSError *error) {
            if (loginDictionary.count == 0) {
                callback(@[RCTMakeError(@"Error while getting login credentials.", nil, nil)]);
                return;
            }
            
            callback(@[[NSNull null], @{
                           @"username": loginDictionary[AppExtensionUsernameKey],
                           @"password": loginDictionary[AppExtensionPasswordKey]
                           }]);
        }];
    });
}

@end
