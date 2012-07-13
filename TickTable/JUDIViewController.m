//
//  JUDIViewController.m
//  TickTable
//

#import "JUDIViewController.h"

@interface JUDIViewController ()
@property (strong, nonatomic) NSArray *tricksArray;
@property (strong, nonatomic) UIImage *tickedBox;
@property (strong, nonatomic) UIImage *untickedBox;
@end

@implementation JUDIViewController
@synthesize trickTable;
@synthesize tickedBox;
@synthesize untickedBox;
@synthesize tricksArray;
@synthesize tricksDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // build our trick dictionary. We'll use this to hold the state of the
    // checkboxes
    tricksDictionary    = [[NSMutableDictionary alloc]
                           initWithObjectsAndKeys:
                           [NSNumber numberWithInteger:0],@"Nollie 360", 
                           [NSNumber numberWithInteger:0],@"The Broadwalk",
                           [NSNumber numberWithInteger:0],@"Heelside Cartwheel",
                           [NSNumber numberWithInteger:0],@"Nollie Tailtap",
                           [NSNumber numberWithInteger:0],@"Nose Butter 180",
                           [NSNumber numberWithInteger:0],@"Nose Manual",
                           nil];
    
    // build an array of trick names
    self.tricksArray    = [[self.tricksDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    // load our tick / untick images
    self.tickedBox      = [UIImage imageNamed:@"checkbox_ticked.png"];
    self.untickedBox    = [UIImage imageNamed:@"checkbox_not_ticked.png"];
}

- (void)viewDidUnload
{
    [self setTricksDictionary:nil];
    [self setTrickTable:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // standard stuff :)
    return [self.tricksArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // standard table stuff
    static NSString *tableIdentifier    = @"TableID";
    UITableViewCell *cell               = [tableView 
                                           dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell == nil) {
        cell        = [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault    // this will provide use a cell with an image element
                       reuseIdentifier:tableIdentifier];            // out of the box! We'll use that down below
    }
    
    // Now to display our tickbox
    // get row
    NSUInteger row          = [indexPath row];
    // using row get trick text
    NSString *trickText     = [self.tricksArray objectAtIndex:row];
    // using trick text get value it's value form our dictionary 
    NSNumber *trickState    = [tricksDictionary objectForKey:trickText];
    
    // now we have the state decided which image to show
    if([trickState boolValue])
        cell.imageView.image    = tickedBox;
    else
        cell.imageView.image    = untickedBox;
    
    // and display trick text
    cell.textLabel.text         = trickText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // pull cell from table
    UITableViewCell *cell   = [tableView cellForRowAtIndexPath:indexPath];
    
    // as before
    NSUInteger row          = [indexPath row];
    NSString *trickText     = [self.tricksArray objectAtIndex:row];    
    NSNumber *trickState    = [tricksDictionary objectForKey:trickText];


    
    // the reverse of what we did before
    // Remembering to update our dictionary so the next time
    // the row is selectedthe logic is right
    if([trickState boolValue]) {
        cell.imageView.image    = untickedBox;
        [tricksDictionary setValue:[NSNumber numberWithInteger:0] forKey:trickText];
    } else {
        cell.imageView.image    = tickedBox;
        [tricksDictionary setValue:[NSNumber numberWithInteger:1] forKey:trickText];
    }
}


@end
