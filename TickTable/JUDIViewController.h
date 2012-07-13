//
//  JUDIViewController.h
//  TickTable

#import <UIKit/UIKit.h>

@interface JUDIViewController : UIViewController
                <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *trickTable;
@property (strong, nonatomic) NSMutableDictionary *tricksDictionary;
@end
