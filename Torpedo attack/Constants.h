#define SOUNDBACKGROUND_KEY       @"SOUNDBACKGROUND_KEY"
#define SOUNDEFFECTS_KEY       @"SOUNDEFFECTS_KEY"
#define DESTROYED_KEY       @"DESTROYED_KEY"
#define STRIKE_KEY       @"STRIKE_KEY"
#define HARD_KEY       @"HARD_KEY"

//boat
#define DEFINE_BOAT_WIDTH 180
#define DEFINE_MOVE_TORPEDO 5

#define PORTRAIT @"Portrait"
#define LANDSCAPE @"Landscape"
#define FROM_RIGHT @"fromRight"
#define FROM_LEFT @"fromLeft"


#define BINOKLE1_NAME @"binokle1"
#define BINOKLE_NAME @"binokle"

#define BINOKLE_NAME_MAIN BINOKLE_NAME

#define DEFINE_BOAT_WIDTH 180
#define DEFINE_MOVE_TORPEDO 5

//не трогать
#define ROCK_WIDTH 200
#define ROCK_HEIGHT ROCK_WIDTH/1.66

#define FLASH 70
#define SMOKE_WIDTH FLASH
#define SMOKE_HEIGHT FLASH

#define YES_KEY @"YES"
#define NO_KEY @"NO"

//sound
#define LAUNCH @"launch"
#define EXPLOSION @"explosion"


#define MENU_BUTTON_WIDTH 200
#define MENU_BUTTON_HEIGHT MENU_BUTTON_WIDTH/3
#define  MENU_BUTTON_VISOTA 50

//RU
#define VISOTA_O  150
#define  SHIRINA_O  VISOTA_O/2
#define  VISOTA_O_P  100
#define  SHIRINA_O_P  VISOTA_O_P/2
#define  VISOTA_A  160
#define  VISOTA_A_P  100
#define  SHIRINA_A  VISOTA_A/2.58
#define  SHIRINA_A_P  VISOTA_A_P/2.58
#define OTSPUT 90
#define  OTSPUP_P 7.5


//US
#define VISOTA_O_US  140
#define  SHIRINA_O_US  VISOTA_O_US/2
#define  VISOTA_O_P_US  100
#define  SHIRINA_O_P_US  VISOTA_O_P/2

#define  VISOTA_A_US  160
#define  VISOTA_A_P_US  100
#define  SHIRINA_A_US  VISOTA_A_US/2.34
#define  SHIRINA_A_P_US  VISOTA_A_P_US/2.34
#define  OTSTUP_US 90
#define  OTSTUP_P_US 4.5




//arrays
#define ARRAY_BOAT_WIDTH [[NSArray alloc] initWithObjects:@"100",@"105", @"110", @"115", @"120", @"125", @"130", @"135", @"140", @"145", @"150", @"155", @"160", @"165", @"170", @"175", @"180", nil]

#define MAIN_BOAT_NAME_R @"boat1_r"
#define ARRAY_BOATS_RIGHT  [[NSArray alloc] initWithObjects:MAIN_BOAT_NAME_R,@"boat2_r", @"boat3_r", @"boat4_r", @"boat5_r", @"boat6_r", @"boat7_r", @"boat8_r", @"boat9_r", @"boat10_r", @"boat11_r", @"boat12_r", @"boat13_r", @"boat14_r", @"boat15_r", @"boat16_r", @"boat17_r", @"boat18_r", @"boat19_r", @"boat20_r", nil];

#define MAIN_BOAT_NAME_L @"boat1_l"
#define ARRAY_BOATS_LEFT [[NSArray alloc] initWithObjects:MAIN_BOAT_NAME_L,@"boat2_l", @"boat3_l", @"boat4_l", @"boat5_l", @"boat6_l", @"boat7_l", @"boat8_l", @"boat9_l", @"boat10_l", @"boat11_l", @"boat12_l", @"boat13_l", @"boat14_l", @"boat15_l", @"boat16_l", @"boat17_l", @"boat18_l", @"boat19_l", @"boat20_l", nil]

#define ARRAY_DURATION_TORPEDO [[NSArray alloc] initWithObjects:@"5",@"6", @"7", @"8", @"9", nil]
#define sizeBOAT 0.75


#define TEXT_ORDERS_1 @"You have been awarded the next military rank Ensign.\n\nMove forward into a given square and begin a combat mission."
