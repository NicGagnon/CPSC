#include <stdlib.h>
#include <stdio.h>
#include "node.h"
#include "integernode.h"

struct IntegerNode_class IntegerNode_class_table = {
  &Node_class_table,  /* super */
  IntegerNode_compareTo,
  IntegerNode_printNode,
  Node_insert,
  Node_print,
  IntegerNode_delete,
  IntegerNode_sum,
};

void IntegerNode_ctor(void* thisv, int* s) {
  struct IntegerNode* this = thisv;
  Node_ctor(this);
  this->s = *s;
}

int IntegerNode_compareTo(void* thisv, void* nodev) {
  struct IntegerNode* this = thisv;
  struct IntegerNode* node = nodev;
  if (this->s == node->s)
    return 0;
  else if (this->s > node->s)
    return 1;
  else return -1;
}

void IntegerNode_printNode(void* thisv) {
  struct IntegerNode* this = thisv;
  printf("%d\n", this->s);
}

int IntegerNode_sum(void* thisv) {
    struct IntegerNode* this = thisv;
    int var1 = this->s;
    if (this->left != NULL)
        var1 += IntegerNode_sum(this->left);
    if (this->right != NULL)
            var1 += IntegerNode_sum(this->right);
    return var1;
}

void* new_IntegerNode(int s) {
  struct IntegerNode* obj = malloc(sizeof(struct IntegerNode));
  obj->class = &IntegerNode_class_table;
  IntegerNode_ctor(obj, &s);
  return obj;
}

void IntegerNode_delete(void* thisv) {
    struct IntegerNode* this = thisv;
    if (this != NULL) {
        IntegerNode_delete (this->left);
        IntegerNode_delete (this->right);
        //free (this->s);
        free (this);
    }
}