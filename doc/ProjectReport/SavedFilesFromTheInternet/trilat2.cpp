/**************************************************************************
 * This code was written by Peter McLachlan 
 * mpeter29@earthlink.net
 * This is a trilateration algorithm devised by Peter McLachlan for a
 * biological survey paper by Kelly Gallagher kelly@isem.univ-montp2.fr
 * 8/13/03
 * Keywords: "Anchor free localization", "Ad-hoc", "Mass-spring optimization"
 *   "Iterative averaging", "Trilateration", "2-D"
 ***************************************************************************/

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <vector>
#include <map>
#include <set>
#include <cmath>
#include <algorithm>

using namespace std;
#define PI 3.14159265359

template<typename T>
T sqr(const T x) {
  return x*x;
};

//This contains a single element of raw data from file input
struct inp {
  int a, b;
  double d;
  void display() const {
    cout<<"loc1 "<<a<<" loc2 "<<b<<" dist "<<d<<endl;
  }
};

//HERE IS THE PLANT CLASS!!
class plant {
private:
  double position[2];
  map<int,double> friend_distance;

public:
  plant(double x, double y, inp& one_fiend) {
    position[0] = x;
    position[1] = y;
    friend_distance[one_fiend.b] = one_fiend.d;
  }

  //Default constructor.  If the code goes here, something went wrong.
  plant() {
    position[0] = 0.0;
    position[1] = 0.0;
    friend_distance[0] = 0.0;
  }

  void display() const {
    cout<<"X= "<<position[0]<<" Y= "<<position[1]<<endl;
    map<int,double>::const_iterator iter;
    for (iter = friend_distance.begin(); iter != friend_distance.end(); 
         ++iter){
      cout<<"Friend #"<<iter->first<<" Has an expected distance of "
          <<iter->second<<endl;
    }
  }

  void addfriend(inp& input) {
    friend_distance[input.b] = input.d;
  }

  //Move the plant along an average of all vectors.  The vector toward each 
  //friend is half the difference of the actual minus expected distance.
  double move(map<int,plant>& allplants){
    double bdist;
    double residual = 1.0;
    double dist_diff = 1.0;
    double vb_new[2];
    double tmp_position[2] = {0.0,0.0};
    double xdiff = 0.0;
    double ydiff = 0.0;
    double max_residual = 0.0;
    int thisfriend;
    int n = 0;
    map<int,double>::const_iterator iter;
    for (iter = friend_distance.begin(); iter != friend_distance.end(); 
         ++iter){
      thisfriend = iter->first;
      xdiff = allplants[thisfriend].getPosition(0) - position[0];
      ydiff = allplants[thisfriend].getPosition(1) - position[1];
      bdist = sqrt( sqr(xdiff) + sqr(ydiff) );
      dist_diff = bdist - iter->second;
      residual = abs(dist_diff);
      if (residual>max_residual) max_residual = residual;
      vb_new[0] = (dist_diff * xdiff)/(2.0 * bdist);
      vb_new[1] = (dist_diff * ydiff)/(2.0 * bdist);
      tmp_position[0] += vb_new[0];
      tmp_position[1] += vb_new[1];
      n++;
    }
    position[0] += tmp_position[0]/n;
    position[1] += tmp_position[1]/n;
    return max_residual;  //return the maximum error encountered
  }

  //This provides a complete diagnostic for problem plants
  void printErr(map<int,plant>& allplants){
    double bdist;
    double residual = 1.0;
    double dist_diff = 1.0;
    double xdiff = 0.0;
    double ydiff = 0.0;
    int thisfriend;
    map<int,double>::const_iterator iter;
    for (iter = friend_distance.begin(); iter != friend_distance.end(); 
         ++iter){
      thisfriend = iter->first;
      xdiff = allplants[thisfriend].getPosition(0) - position[0];
      ydiff = allplants[thisfriend].getPosition(1) - position[1];
      bdist = sqrt( sqr(xdiff) + sqr(ydiff) );
      dist_diff = bdist - iter->second;
      residual = abs(dist_diff);
      cout<<"Error to friend "<<thisfriend<<" is "<<residual<<endl;
    }
  }

  double getPosition(int coord) {
    return position[coord];
  }
};


struct myequal{
  bool operator()(const inp &item1, const inp &item2) {
  if ((item1.a==item2.a) && (item1.b==item2.b) && (item1.d==item2.d))
    return true;
  else return false;
  }
};

bool order(const inp &item1, const inp &item2) {
  if(item1.a < item2.a) return true;
  else if ((item1.a==item2.a) && (item1.b < item2.b)) return true;
  else return false;
};

// print out a simple usage message and exit
void usage(int, char *argv[], int retval) {
  cout << "\n  Usage of this code is of the form:" << endl;
  cout << argv[0] << " -file <filename> -max_iter <integer> -max_err <float>" 
       << endl;
  cout << "\n  The input file should be a list of plants and distances."<< endl
       << "For example, an entry for the distance between plant three "<< endl
       << "and sixteen: 3 16 34.5"<< endl
       << "Every plant should have three distances associated with it somehow."
       << endl;
  cout << "\n  The distance between all plants will be placed in the"<< endl
       << "file \"Dist_out.data\""
       << endl;
  cout << "\n  The X-Y locations of all plants (for plotting purposes)"<< endl
       << "will be placed in the file \"Loc_out.data\""
       << endl;
  cout << "\n Error codes: ";
  cout << "\n   0: No detected errors";
  cout << "\n   1: Error in reading data file";
  cout << "\n   2: Error in command-line parameters";
  cout << "\n   3: Please supply the maximum # of iterations";  
  cout << "\n      Default = 10,000";
  cout << "\n   4: Please supply the input file name.  The test data file:";
  cout << "\n      \"TestData\" will create a regular hexagon with sides";
  cout << "\n      of length 0.57735";
  cout << "\n   5: Please supply the maximum error in the distance between";
  cout << "\n      any two plants.  The default = 0.01";
  cout << endl;
  exit(retval);
}

int main(int argc, char *argv[])  //--------------MAIN---------------------
{
  //INPUT AND PRINT----------------------------------------
  // parse command-line options to get info
  long int i;  //loop variable
  char *infile = 0;  //input file
  int max_iter=100000;
  float max_err = 0.01;
  // we need some kind of arguments
  if (argc == 1) usage(argc, argv, 4);
  for (i=1; i < argc; ++i) {
    if (!strcmp(argv[i], "-max_iter")) {
      if (i < (argc - 1))
	max_iter = atoi(argv[++i]);
      else 
	usage(argc, argv, 3);
    } else if (!strcmp(argv[i], "-file")) {
      if (i < (argc - 1))
	infile = argv[++i];
      else
	usage(argc, argv, 4);
    } else if (!strcmp(argv[i], "-max_err")) {
      if (i < (argc - 1))
	max_err = atof(argv[++i]);
      else
	usage(argc, argv, 5);
    } else {
      cout << "Unknown option '" << argv[i] << "'." << endl;
      usage(argc, argv, 2);
    }
  }

  ifstream indataf(infile, ios::in);
  if (indataf.fail()) {
    cerr << "file not found\n";
    exit(1);
  }
  indataf.clear();
  indataf.seekg(0);
  inp input;
  vector<inp> master;  //This will contain all the raw input data
  vector<inp>::iterator mast_if;
  int loc1, loc2;
  double dist;
  //Input
  while(indataf >> loc1 >> loc2 >> dist) {
    input.a = loc1;
    input.b = loc2;
    input.d = dist;
    master.push_back(input);
    input.a = loc2;
    input.b = loc1;
    master.push_back(input);
  }
  //Sort and remove duplicates
  myequal equaltest;
  sort(master.begin(),master.end(),order);
  mast_if = adjacent_find(master.begin(),master.end(),equaltest);
  while(mast_if != master.end()){
    mast_if = master.erase(mast_if);
    mast_if = adjacent_find(mast_if,master.end(),equaltest);
  }
  //Print results of input
  cout<<"The size of the vector is: "<<master.size()<<endl;
  input = master.back();
  cout<<"The last element of the vector is: "<<input.a<<" "<<input.b<<" "<<
    input.d<<endl;
  cout<<endl<<"The whole vector looks like:"<<endl;
  mast_if = master.begin();
  while (mast_if != master.end()) {
    (*mast_if).display();
    mast_if++;
  }

  //UNIQUE AND CONTIGUOUS-------------------------------------
  int numOfOneFriends = 0;
  int numOfTwoFriends = 0;
  int numOfZeroFriends = 0;
  int unique = 0;
  set<int> badset;
  int test = 0;
  int count = 0;
  bool trimmed = true;
  //Construct a set "badset" of non-unique locations to be excluded 
  //from all further calculations.
  //A fundamental set is arrived at through a recursive testing and 
  //trimming of the master list.
  while (trimmed == true){
    trimmed = false;
    unique = 0;
    mast_if = master.begin();
    while (mast_if != master.end()) {
      test = (*mast_if).a;
      if (badset.find(test) != badset.end()) {
	mast_if++;
	continue;
      }
      unique++;
      count = 0;
      while ( (test == (*mast_if).a) && (mast_if != master.end()) ) {
	if (badset.find((*mast_if).b) != badset.end()) {
	  mast_if++;
	  continue;
	}
	mast_if++;
	count++;
      }
      if (count==2) {
	cout<<"Location "<<test<<endl;//" has only two friends"<<endl;
	badset.insert(test);
	trimmed = true;
	numOfTwoFriends++;
	unique--;
      }
      if (count==1) {
	cout<<"Location "<<test<<endl;//" has only one friend"<<endl;
	badset.insert(test);
	trimmed = true;
	numOfOneFriends++;
	unique--;
      }
      if (count==0) {
	cout<<"Location "<<test<<endl;//" has zero friends"<<endl;
	badset.insert(test);
	trimmed = true;
	numOfZeroFriends++;
	unique--;
      }
      if ( (mast_if != master.end()) && ((*mast_if).a - test != 1) ) 
	cout<<"There is a discontinuity between location "
	    <<test<<" and location "<<(*mast_if).a<<endl;
    }
    //This information is not terribly useful because bad locations have
    //already been removed from knowledge and may affect the calculation of
    //future locations.
    cout<<endl<<"There is a total of "<<unique
	<<" locations that have three or more friends."<<endl
	<<"A total of "
	<<numOfTwoFriends<<" locations that have only two friends, "<<endl
	<<numOfOneFriends<<" locations that have only one friend,"<<endl
	<<"and a total of "<<numOfZeroFriends
	<<" locations that have zero friends."<<endl;
  }
  //This is important.  The calculations will only be run on this fundamental 
  //set
  cout<<endl<<"There is a total of "<<unique
      <<" unique locations in the fundamental set."<<endl;

  //CONVERT INPUT VECTOR TO MAP OF CLASS PLANT
  //ASSIGNMENT OF INITIAL COORDINATES: A RANDOM LOCATION ON UNIT CIRCLE------
  map<int,plant> plants; //Map of all plants
  map<int,plant>::iterator plants_iter;
  double angle = 0.0;
  double x = 1.0;
  double y = 1.0;
  mast_if = master.begin();
  while (mast_if != master.end()) {
    test = (*mast_if).a;
    if (badset.find(test) != badset.end()) {
      mast_if++;
      continue;
    }
    if (badset.find((*mast_if).b) != badset.end()) {
      mast_if++;
      continue;
    }
    angle = 2.0*PI*(rand()/((double)RAND_MAX));
    x = cos(angle);
    y = sin(angle);
    //Instantiate a plant with its first friend
    plant one_plant(x,y,*mast_if);
    mast_if++;
    //Add additional friends to the plant
    while ( (test == (*mast_if).a) && (mast_if != master.end()) ) {
      if (badset.find((*mast_if).b) != badset.end()) {
	mast_if++;
	continue;
      }
      one_plant.addfriend(*mast_if);
      mast_if++;
    }
    //Insert this plant into the map of all plants
    plants.insert( map<int,plant>::value_type(test,one_plant) );
  }
  //Here is the complete initial information known by each plant
  cout<<endl<<"PLANT INITIAL COORDINATE INFORMATION:"<<endl;
  for (plants_iter = plants.begin(); 
       plants_iter != plants.end(); ++plants_iter){
    cout<<"Info for plant "<<plants_iter->first<<endl;
    plants_iter->second.display();
  }
  
  //RELAXATION LOOP------------------------------------------------------
  map<int,plant> plants_tmp(plants);
  cout<<endl<<"---------------RELAXATION LOOP PLANT OUTPUT:------------"<<endl;
  double rel_error = 0.0;
  double tmp_error = 1.0;

  i=0;
  rel_error = 1.0;
  while(i<max_iter && rel_error>max_err){
    rel_error = 0.0;
    for (plants_iter = plants.begin(); 
	 plants_iter != plants.end(); ++plants_iter){
      tmp_error = plants_iter->second.move(plants_tmp);
      //cout<<"Temp error for plant "<<plants_iter->first<<" is "
      //<<tmp_error<<endl;
      if (tmp_error>rel_error) rel_error = tmp_error;
    }
    //cout<<"The maximum relative error = "<<rel_error<<endl<<endl;
    ++i;
    plants_tmp = plants;
  }

  //One final move to print out which plants have the largest error
  rel_error = 0.0;
  for (plants_iter = plants.begin(); 
       plants_iter != plants.end(); ++plants_iter){
    tmp_error = plants_iter->second.move(plants_tmp);
    cout<<"Temp error for plant "<<plants_iter->first<<" is "
    	<<tmp_error<<endl;
    if (tmp_error>rel_error) rel_error = tmp_error;
  }
  cout<<"The maximum relative error = "<<rel_error<<endl<<endl;
  ++i;

  cout<<endl<<"There were "<<i<<" iterations in the relaxation loop "<<endl
      <<"to a relative error of "<<rel_error<<endl;

  //Complete error information for problem plants 
  /*
  cout<<endl<<"All the problems with plant 132: "<<endl;
  plants[132].printErr(plants);
  */

  //OUTPUT OF FINAL RESULTS-----------------------------------------------
  //Complete knowledge from each plant
  
  for (plants_iter = plants.begin(); 
       plants_iter != plants.end(); ++plants_iter){
    cout<<"Info for plant "<<plants_iter->first<<endl;
    plants_iter->second.display();
  }
  
  //A file for plotting purposes
  ofstream outdataf("Loc_out.data", ios::out);
  if (outdataf.fail()) {
    cerr << "output file not opened\n";
    exit(1);
  }
  for (plants_iter = plants.begin(); 
       plants_iter != plants.end(); ++plants_iter){
    outdataf<<plants_iter->second.getPosition(0)<<" "
	    <<plants_iter->second.getPosition(1)<<endl;
  }
  outdataf.close();
  
  //Output all distances for all plants to a file
  map<int,plant>::iterator plants_iter2;
  double bdist = 0.0;
  double xdiff = 0.0;
  double ydiff = 0.0;
  int thisfriend = 0;
  ofstream outalldistf("Dist_out.data", ios::out);
  if (outalldistf.fail()) {
    cerr << "output file not opened\n";
    exit(1);
  }
  for (plants_iter = plants.begin(); 
       plants_iter != plants.end(); ++plants_iter){
    for (plants_iter2 = plants.begin(); 
	 plants_iter2 != plants.end(); ++plants_iter2){
      xdiff = plants_iter->second.getPosition(0) 
            - plants_iter2->second.getPosition(0);
      ydiff = plants_iter->second.getPosition(1) 
            - plants_iter2->second.getPosition(1);
      bdist = sqrt( sqr(xdiff) + sqr(ydiff) );
      outalldistf<<plants_iter->first<<" "
		 <<plants_iter2->first<<" "
		 <<bdist<<endl;
    }
  }
  outalldistf.close();

  return 0;

} //End Main
