#include <iostream>

/*
Очередь целых чисел с ограничением на длину очереди
q<<n1<<n2<<n3 (q-объект класса, n1,n2,n4-произвольные целочисленные выражения)
заносит в очередь указанные числа
q>>m1>>m2>>m3 извлекает числа из очереди в переменные m1,m2,m3
Condition == true в базовом классе, в наследуемых
не позволяет занести в очередь числа x<0 || x>99
*/

using namespace std;

class BadQLen {};
class QEmpty {};

class LimIntQ
{
    int *m;
    int len;
    int cur;
    public:
    LimIntQ (int x)
    {
        cur = 0;
        if (x < 1) {
            throw BadQLen ();
            x = 1;
        }
        len = x;
        m = new int [len];
    }
    void Put (int x)
    {
        if (cur < len) {
            m [cur] = x;
            cur++;
        }
        else {
            for (int i = 0; i < len; i--) {
                m [i] = m [i + 1];
            }
        }
        m [cur] = x;
    }
    bool Get (int &x)
    {
        if (cur == 0) {
            throw QEmpty ();
            return false;
        }
        x = m [0];
        if (len != 0) {
            for (int i = 0; i < cur - 1; i++) {
                m [i] = m [i + 1];
            }
        }
        cur--;
        return true;
    }
    int Count ()
    {
        return cur;
    }
    LimIntQ &operator << (int x)
    {
        Put (x);
        return *this;
    }
    LimIntQ &operator >> (int &x)
    {
        Get (x);
        return *this;
    }
};

int main ()
{
    /*
    LimIntQ a (10);
    a.Put (1);
    a.Put (2);
    a.Put (3);
    a.Put (4);
    int c;

    int l = a.Count ();
    for (int i = 0; i < l + 3; i++) {
        bool b = a.Get (c);
        if (b == true) cout << c << endl;
        else cout << "End" << endl;
    }
    */
    return 0;
}
