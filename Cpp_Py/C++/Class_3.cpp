#include <iostream>
/*
Body-абстрактное физическое тело
Требуется посчитать объем.
Задана плотность тела, но не задана форма
Класс Ball наследуется от класса Body, известен радиус
Возможно наследование других потомков (форм)
*/
using namespace std;

class Body
{
    protected:
    double p;

    public:
    virtual double Volume () const = 0;

    double Mass () const
    {
        return Volume () * p;
    }
    Body (double arg)
    {
        p = arg;
    }
    ~Body () {}
};

class Ball : public Body
{
    protected:
    double rad;

    public:
    Ball (double r, double t) : Body (t), rad (r) {}
    double Volume () const
    {
        return 4 * 3.14 * rad * rad * rad / 3;
    }
    ~Ball () {}
};

int main()
{
    /*
    Ball b (2, 1);

    cout << b.Mass () << endl;
    */
    return 0;
}
