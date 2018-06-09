#ifndef __INTEGERNODE_H__
#define __INTEGERNODE_H__

/**
 * struct definition of class and external definition of class table
 */
struct IntegerNode_class {
  struct Node_class* super;
  int  (*compareTo) (void*, void*);
  void (*printNode) (void*);
  void (*insert)    (void*, void*);
  void (*print)     (void*);
  void (*deleteNode)(void*);
  int  (*sum)       (void*);
};
extern struct IntegerNode_class IntegerNode_class_table;

/**
 * struct definition of object
 */
struct IntegerNode;
struct IntegerNode {
  struct IntegerNode_class* class;

  // instance variables defined in super class(es)
  struct IntegerNode* left;
  struct IntegerNode* right;

  // instance variables defined in this class
  int s;
};

/**
 * definition of methods implemented by this class
 */
void IntegerNode_ctor(void*, int*);
int IntegerNode_compareTo(void*, void*);
void IntegerNode_printNode(void*);
int IntegerNode_sum(void*);
void IntegerNode_delete(void*);

/**
 * definition of new for class
 */
void* new_IntegerNode(int);

#endif /*__INTEGERNODE_H__*/
