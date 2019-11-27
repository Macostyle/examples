#include <iostream>
#include <vector>

/*
Сортировка произвольного объекта
*/

using namespace std;

template <typename T>
void Sort (vector <T> &t)
{
    typename vector <T> :: iterator i = t.begin ();
    typename vector <T> :: iterator j;
    while (i + 1 != t.end ()) {
        j = i;
        j++;
        while (j != t.end ()) {
            if (*i > *j) {
                T t = *i;
                *i = *j;
                *j = t;
            }
            j++;
        }
        i++;
    }
}

template <typename T>
void Print (vector <T> t)
{
    typename vector <T> :: const_iterator i;
    for (i = t.begin (); i != t.end (); i++) {
        cout << *i << ' ';
    }
    cout << endl;
}

int main ()
{
    /*
    vector <int> t;
    t.push_back (1);
    t.push_back (3);
    t.push_back (2);
    t.push_back (4);
    t.push_back (5);
    Sort (t);
    Print (t);
    */
    return 0;
}
