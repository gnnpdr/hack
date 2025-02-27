# HACK

My friend said that I can play Portal 3 and gave me this, I don't know, gemekey? Anyway, I can't open it!

![badend](https://github.com/gnnpdr/hack/raw/master/images/badend.png)

But I have a plan! I will analyze the code of this program and try to hack it.

## First vulnerability (say no more)

In the part of the program where the entered line is processed, we can see this:

![space code](https://github.com/gnnpdr/hack/raw/master/images/space.png)

So! If you enter space, you'll jump to the address 002E the positive message. 

![first](https://github.com/gnnpdr/hack/raw/master/images/first.png)

**BOOM! We _hacked_ it!**

## Second vulnerability (dictatorship of the proletariat)

We can see. So we see that password string address is 0379 and beffer address is 0366. Here:

![address](https://github.com/gnnpdr/hack/raw/master/images/addresses.png)

**WOW!**  

At address 0366 there is place for seven characters of the password and one for a line break OD:

![buffer](https://github.com/gnnpdr/hack/raw/master/images/buffer.png)

And program have check for eight password symbs. We print eight random symbs and repeat the sequence for covering caret symbol. 

![second](https://github.com/gnnpdr/hack/raw/master/images/second.png)

## Cracking

In the picture of password analysis we saw conditional jump to the string with good words. We can change it to unconditional jump so any password will be correct:

![change](https://github.com/gnnpdr/hack/raw/master/images/change.png)

It is at address 0024. We should change 36th byte. We do it in program crack.cpp. And while the bytes are changing, a new file is created you can see the picture and listen to the music:

![picture](https://github.com/gnnpdr/hack/raw/master/images/picture.png)


The music will repeat until you enter 1 in the console, then you can close the window.