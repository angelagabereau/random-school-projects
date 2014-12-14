#include "field.h"
#include "name.h"
#include "amount.h"
#include "date.h"
#include "form.h"
#include<string>
#include<iostream.h>
#include<cctype>
#include <iostream> 
#include <string> 
#include <stdlib.h> 


using namespace std;


int main(){

/*	Field * name1 = new Name;
	(name1)->fillField("nameOne . , - ' ");
	//cout <<"what's the problem"<<endl;
	string s1 = (name1)->getDescription();
	string s2 = (name1)->getData();
	std::cout<<s1<<" = "<<s2<<endl;
	(name1)->~Field();
	Field * name2 = new Name("NameTwo*");
	std::cout<<endl<<endl;

	(name2)->fillField("nameTwo*");
	string s3 = (name2)->getDescription();
	string s4 = (name2)->getData();
	std::cout<<s3<<" = "<<s4<<endl;
	(name2)->~Field();
	std::cout<<endl<<endl;

	Field * amount1 = new Amount;
	(amount1)->fillField("132454.65.99");
	//cout <<"what's the problem"<<endl;
	string a1 = (amount1)->getDescription();
	string a2 = (amount1)->getData();
	std::cout<<a1<<" = "<<a2<<endl;
	(amount1)->~Field();
	std::cout<<endl<<endl;

	Field * amount2 = new Amount("AmountTwo*");

	(amount2)->fillField("10*0.00");
	string a3 = (amount2)->getDescription();
	string a4 = (amount2)->getData();
	std::cout<<a3<<" = "<<a4<<endl;
	(amount2)->~Field();
	std::cout<<endl<<endl;



	Field * date1 = new Date;
	(date1)->fillField("12 12 12");
	string d1 = (date1)->getDescription();
	string d2 = (date1)->getData(); 
	std::cout<<d1<<" = "<<d2<<endl;
	(date1)->~Field();

	std::cout<<endl<<endl;

	Field * date2 = new Date("DateTwo*");

	(date2)->fillField("31 8 67");
	string d3 = (date2)->getDescription();
	string d4 = (date2)->getData();
	std::cout<<d3<<" = "<<d4<<endl;
	(date2)->~Field();
*/




		Form form1;
	form1.addField(new Name);
	form1.addField(new Date);
	form1.addField(new Amount);
	std::cin >> form1;
	std::cout << endl << form1 << endl;


	Form form2;
	form2.addField(new Name("Name"));
	form2.addField(new Name("Maiden Name"));
	form2.addField(new Date("Birth Date"));
	form2.addField(new Date("Start Date"));
	form2.addField(new Amount("Deposit"));
	form2.addField(new Amount("Withdraw"));
	std::cin >> form2;
	std::cout << endl << form2 << endl;

	return 0;
}
