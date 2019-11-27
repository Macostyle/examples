#include <iostream>

/*
Перегрузка основных операторов
*/

using namespace std;

class Tmp
{
    public:
    int size;
};

class I2
{
    protected:
    int x, y;
    Tmp t;

    public:
    I2 (int a = 1, int b = 2) : x (a), y (b) {}

    friend I2 operator + (I2 a, I2 b);
    I2 operator - (I2 b)
    {
        I2 t;
        t.x = x - b.x;
        t.y = y - b.y;
        return t;
    }

    friend ostream& operator << (ostream& out, const I2 &c);

    I2 operator = (const I2 &k)
    {
        x = k.x;
        y = k.y;
        return *this;
    }

    I2 operator * (I2 b)
    {
        x = x - b.x;
        y = y - b.y;
        return *this;
    }
    Tmp * operator -> ()
    {
        t.size = x + y;
        return &t;
    }
};

ostream& operator << (ostream& out, const I2 &c)
{
    out << c.x << ' ' << c.y;
    return out;
}

I2 operator + (I2 a, I2 b)
{
    I2 t;
    t.x = a.x + b.x;
    t.y = a.y + b.y;
    return t;
}


class C
{
    private:
    I2 *p;
    int n = 0;
    int cur = 0;
    Tmp tmp;

    public:
    C (int m = 10) {
        p = new I2 [m];
        n = m;
    }
    friend ostream& operator << (ostream& out, const C &c);
    C operator + (const C &c)
    {
        C t (n + c.n);
        int j = 0;
        for (int i = 0; i < n; i++, j++) {
            t.p [j] = p [i];
        }
        for (int i = 0; i < c.n; i++, j++) {
            t.p [j] = c.p [i];
        }


        return t;

    }

    C& operator = (const C & c)
    {
        if (&c == this) return *this;
        if (n > 0) {
            delete [] p;
        }
        p = new I2 [c.n];
        n = c.n;
        for (int i = 0; i < n; i++) {
            p [i] = c.p [i];
        }
        return *this;
    }

    I2& operator [] (int i)
    {
        return p [i];
    }

    C& operator , (int j)
    {
        p = (I2*) realloc (p, (n + 1) * sizeof (I2));
        p [n] = {j,0};
        n++;
        //p [n].y = 0;
        return *this;
    }

    I2 operator () (int i, int j)
    {
        I2 res = {0, 0};
        while (i <= j) {
            res = res + p [i];
            i++;
        }
        return res;
    }

    I2 operator () (int i)
    {
        return p [i];
    }

    Tmp * operator -> ()
    {
        tmp.size = n;
        return &tmp;
    }
    int operator ++ ()
    {
        cur++;
        return cur;
    }
};

ostream& operator << (ostream& out, const C &c)
{
    for (int i = 0; i < c.n; i++) {
        out << c.p [i] << " | ";
    }
    return out;
}


int main ()
{
    /*
    I2 a, b, c, d = {5,0};

    C v (3), w (5), u;
    cout << u << endl;
    u, 1, 3;
    //v [2] = I2 (5, 5);
    //v [0] = ;
    //v [0] = ;


    cout << u << endl;
    u =v + w;
    cout << v + w << endl;
    u = u;
    cout << u (3, 5) << " | " << u (6) << endl;

    cout << u [1]->size << endl;
    */
    return 0;
}
