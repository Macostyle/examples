#include <iostream>
/*
Кольцевой односвязный список целых чисел
Count возвращает количество элементов в списке
++lst меняет текущий элемент на следующий
lst->x равно числу из текущего элемента
Check == true в базовом классе, в наследуемых
добавление числа происходит только
при Check == true (добавляемое число > 0)
*/
using namespace std;

struct Node
{
    int data;
    struct Node *next;
};

class ListEmpty
{};

class IntRing
{
    struct Node *head = NULL;
    int num = 0;
    public:

    void Add (int x)
    {
        if (Check (x)) {
            Node *p = new Node;
            p->data = x;
            num++;
            if (head == NULL) {
                p->next = p;
                head = p;
            }
            else {
                p->next = head->next;
                head->next = p;
            }
        }
    }
    void Remove ()
    {
        Empty ();
        if (head->next == head) {
            delete head;
            head = NULL;
        } else {
            Node *p = Pred ();
            p->next = head->next;
            delete head;
        }
        num--;
    }
    Node *Pred ()
    {
        Node *p;
        for (p = head; p->next != head; p = p->next);
        return p;
    }
    int Count () const
    {
       return num;
    }
    int Get () const
    {
        Empty ();
        return head->data;
    }
    IntRing () {}
    ~IntRing () {}
    void Empty () const
    {
        if (head == NULL) throw ListEmpty ();
        else return;
    }
    friend ostream& operator << (ostream& out, IntRing I);
    void operator ++ ()
    {
        head = head->next;
    }
    int s;
    virtual bool Check (int arg) const
    {
        return true;
    }
};

class PositiveIntRing : public IntRing
{
    virtual bool Check (int arg) const
    {
        if (arg > 0) return true;
        else return false;
    }
};

ostream& operator << (ostream& out, IntRing I)
{
    Node *p = I.head;
    for (int i = 0; i < I.num; i++, p = p->next) {
        out << p->data << ' ';
    }
    out << endl;
    return out;
}

int main ()
{
    /*
    IntRing a;
    a.Add (1);
    ++a;
    a.Add (2);
    ++a;
    a.Add (3);
    ++a;
    a.Add (4);
    ++a;
    cout << a << endl;
    //cout << a->s << endl;
    cout << "Nothing" << endl;
    PositiveIntRing b;
    b.Add (1);
    ++b;
    b.Add (2);
    ++b;
    b.Add (-1);
    ++b;
    b.Add (4);
    ++b;
    cout << b << endl;
    //cout << b->s << endl;
    cout << "Nothing" << endl;
    */
    return 0;
}
