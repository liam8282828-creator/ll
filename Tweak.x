#import <UIKit/UIKit.h>

%hook UIWindow
- (void)layoutSubviews {
    %orig;
    if (self.gestureRecognizers.count == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mostrarMenuFF:)];
        tap.numberOfTapsRequired = 2;
        tap.numberOfTouchesRequired = 3;
        [self addGestureRecognizer:tap];
    }
}

%new
- (void)mostrarMenuFF:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        UIAlertController *menu = [UIAlertController alertControllerWithTitle:@"MENU VISUAL FF" 
                                    message:@"2 Toques / 3 Dedos" 
                                    preferredStyle:UIAlertControllerStyleActionSheet];
        [menu addAction:[UIAlertAction actionWithTitle:@"Opción Bypass (Visual)" style:UIAlertActionStyleDefault handler:nil]];
        [menu addAction:[UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:menu animated:YES completion:nil];
    }
}
%end
