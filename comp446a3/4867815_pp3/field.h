#ifndef FIELD_H
#define FIELD_H
/*
 *  field.h
 *  comp446a3
 *
 *  Created by Angela Gabereau on 06/11/06.
 *	ID#: 4867815
 *  COMP 446  
 *  Programming Assignment 3
 *
	base class - abstract class
		constructor 
			takes string or no string in which case desciption of field type is derived class name
		member data
			string description // description of the data stored in this particular field
			string data // the data that the field contains
		member 
		 input - extractor with validation and 
			<description> : 
		 output - insertor
			<description> = <data>
	 


 */
 
 //ABSTRACT BASE CLASS with one or more pure virtual functions (ie fillField)

#include <string>

class Field
{
	//not sure i will use these operator functions
	//friend std::ostream & operator<<(std::ostream & os, const Field & form);
	//friend std::istream & operator>>(std::istream & is, Field & form);

public:
	Field();
	virtual ~Field();//by declaring destructor as virtual ensures no memory leak when deleting derived object
	virtual void fillField(std::string s)=0; 
	std::string showField();  //non-virtual function with implementation
	std::string getDescription() const;
	std::string getData() const;
	
protected:
	void setDescription(std::string des);
	void setData(std::string d);
	
private:
	std::string description;
	std::string data;
};

#endif