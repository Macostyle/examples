#include <iostream>
#include <string.h>

/*
Реализация стека
*/

using namespace std;

struct Node
{
    char *data;
    Node *next;
    Node *prev;
};

class Stack
{
    private:
    Node *head;
    Node *tail;
    public:
    Stack ()
    {
        head = NULL;
        tail = NULL;
    }
    ~Stack ()
    {
        while (head != NULL) {
            delete head->data;
            Node *p = head;
            head = head->next;
            delete p;
        }
    }

    void push (char *c) {
        Node *t = new Node;
        t->data = new char [strlen (c) + 1];
        strcpy (t->data, c);
        if (tail != NULL) {
            tail->next = t;
            t->prev = tail;
            t->next = NULL;
            tail = t;
        } else {
            head = t;
            tail = t;
        }
    }
    void pop ()
    {
        delete tail->data;
        Node *t = tail;
        tail = tail->prev;
        tail->next = NULL;
        delete t;
    }
    void print () const
    {
        Node *t = head;
        while (t != tail->next) {
            cout << (t->data) << ' ';
            t = t->next;
        }
        cout << endl;
    }
};

int main()
{
    /*
    Stack s;

    char a = 'a', b = 'b', c = 'c';
    char d [10] = "1234";
    s.push (d);
    d [0] = 'x';
    s.push ("b");
    s.push ("c");
    s.push ("123");
    s.print ();
    s.pop ();
    s.pop ();
    s.print ();
    */
    return 0;
}
