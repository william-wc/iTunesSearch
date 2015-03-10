//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"

@interface TableViewController () {
    NSArray *midias;
    UITextField *txtValue;
    UIButton *btnSearch;
    iTunesManager *itunes;
}

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    itunes = [iTunesManager sharedInstance];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 30.f)];
    
    txtValue = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, 180, 15)];
    txtValue.backgroundColor = [UIColor redColor];
    [self.tableview.tableHeaderView insertSubview:txtValue atIndex:0];
    
    btnSearch = [[UIButton alloc]initWithFrame:CGRectMake(
                                                          txtValue.bounds.origin.x + txtValue.bounds.size.width + 5,
                                                          15,
                                                          70,
                                                          txtValue.bounds.size.height
    )];
    [btnSearch setTitle:@"Search" forState:UIControlStateNormal];
    [btnSearch setBackgroundColor:[UIColor blueColor]];
    [btnSearch addTarget:self action:@selector(onBtnSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableview.tableHeaderView insertSubview:btnSearch atIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome    setText:filme.nome];
    [celula.tipo    setText:@"Filme"];
    [celula.genero  setText:filme.genero];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:filme.artworkUrl]];
        if(data) {
            UIImage *img = [UIImage imageWithData:data];
            if(img) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    celula.imageView.image = img;
                });
            }
        }
    });
    
    celula.imageView.image = [UIImage imageNamed:filme.artworkUrl];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(IBAction)onBtnSearch:(id)sender {
    NSString *value = txtValue.text;
    if(value && value.length > 0) {
        NSLog(@"SEARCHING");
        midias = [itunes buscarMidias:value];
        [self.tableview reloadData];
    }
}


@end
