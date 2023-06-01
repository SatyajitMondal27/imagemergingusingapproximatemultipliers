clc;
clear all
close all
format long

nRED=0.0;
for i=1:255
    for j=1:255
        r=eightxeight(i,j);
        disp(r);
        M=i*j;
        ED=abs(r-M);
        RED=ED/M;
        nRED=nRED+RED;
    end
end

MRED=nRED/65536;
disp(MRED);
NMED=MRED/65025;
disp(NMED);

function r=eightxeight(a,b)
a=de2bi(a,8);
        b=de2bi(b,8);
        al=a(1:4);
        ah=a(5:8);
        bl=b(1:4);
        bh=b(5:8);
        p1=approxmul(al,bl);
        p2=approxmul(ah,bl);
        p3=approxmul(al,bh);
        p4=wtm(ah,bh);
        r(1)=p1(1);
        r(2)=p1(2);
        r(3)=p1(3);
        r(4)=p1(4);
        [w1,w2]= ha(p2(1),p1(5));
        [w3,w4]= ha(p2(2),p1(6));
        [w5,w6]= ha(p2(3),p1(7));
        [w7,w8]= ha(p2(4),p1(8));
        [w9,w10]= fa(p2(5),p3(5),p4(1));  
        [w11,w12]= fa(p2(6),p3(6),p4(2));
        [w13,w14]= fa(p2(7),p3(7),p4(3));
        [w15,w16]= fa(p2(8),p3(8),p4(4));
        [r(5),w17]= ha(w1,p3(1));
        [w18,w19]= fa(w2,w3,p3(2));
        [w20,w21]= fa(w4,w5,p3(3));
        [w22,w23]= fa(w6,w7,p3(4));
        [w24,w25]= ha(w8,w9);
        [w26,w27]= ha(w11,w10);
        [w28,w29]= ha(w12,w13);
        [w30,w31]= ha(w14,w15);
        [w32,w33]= ha(w16,p4(5));
        [r(6),w34]= ha(w17,w18);
        [r(7),w35]= fa(w19,w20,w34);
        [r(8),w36]= fa(w21,w22,w35);
        [r(9),w37]= fa(w23,w24,w36);
        [r(10),w38]= fa(w25,w26,w37);
        [r(11),w39]= fa(w27,w28,w38);
        [r(12),w40]= fa(w29,w30,w39);
        [r(13),w41]= fa(w31,w32,w40);
        [r(14),w42]= fa(w33,w41,p4(6));
        [r(15),w43]= ha(w42,p4(7));
        r(16)=bitxor(p4(8),w43);
        r=bi2de(r);
end




function [sum,carry]= ha(a,b)
if(a==0&&b==0)
    sum=0;
    carry=0;
elseif(a==0&&b==1)
    sum=1;
    carry=0;
elseif(a==1&&b==0)
    sum=1;
    carry=0;
elseif(a==1&&b==1)
    sum=0;
    carry=1;
end
        
end

function [sum,carry]= fa(a,b,c)
if(a==0&&b==0&&c==0)
    sum=0;
    carry=0;
elseif(a==0&&b==0&&c==1)
    sum=1;
    carry=0;
elseif(a==0&&b==1&&c==0)
    sum=1;
    carry=0;
elseif(a==0&&b==1&&c==1)
    sum=0;
    carry=1;
elseif(a==1&&b==0&&c==0)
    sum=1;
    carry=0;
elseif(a==1&&b==0&&c==1)
    sum=0;
    carry=1;
elseif(a==1&&b==1&&c==0)
    sum=0;
    carry=1;
elseif(a==1&&b==1&&c==1)
    sum=1;
    carry=1;
end
    
end

function p=wtm(a,b)
p(1)=a(1)&b(1);
[p(2),w1] =ha(a(1)&b(2),a(2)&b(1));
[w2,w3]= fa((a(1)&b(3)),(a(2)&b(2)),(a(3)&b(1)));
[w4,w5]= fa((a(4)&b(1)),(a(3)&b(2)),(a(2)&b(3)));
[w6,w7]= fa((a(3)&b(3)),(a(4)&b(2)),(a(2)&b(4)));
[w8,w9] =ha(a(4)&b(3),a(3)&b(4));
[p(3),w10] =ha(w2,w1);
[w11,w12] =fa(w4,a(1)&b(4),w3);
[w13,w14] =ha(w6,w5);
[w15,w16] =ha(w8,w7);
[w17,w18] =ha(a(4)&b(4),w9);
[p(4),w19] =ha(w11,w10);
[p(5),w20]= fa(w13,w12,w19);
[p(6),w21]= fa(w14,w15,w20);
[p(7),w22]= fa(w17,w16,w21);
p(8)=bitxor(w18,w22);
end

function [sum,carry]=four_twocomp(x1,x2,x3,x4)
sums=x1+x2+x3+x4;
x1andx2=x1&x2;
x3andx4=x3&x4;
sumc=x1andx2+x3andx4;
if(sums==0)
    sum=0;
end
if(sums==1)
    sum=1;
end
if(sums==2)
    sum=0;
end
if(sums==3)
    sum=1;
end
if(sums==4)
    sum=0;
end
if(sumc==0)
    carry=0;
end
if(sumc==1)
    carry=1;
end
if(sumc==2)
    carry=0;
end
end
function p=approxmul(a,b)
p(1)=bitand(a(1),b(1));
[p(2),c1]=ha(bitand(a(1),b(2)),bitand(a(2),b(1)));
 pp20=bitand(a(3),b(1));
 pp02=bitand(a(1),b(3));
 P20=bitor(pp20,pp02);
 G20=bitand(pp20,pp02);
[p(3),c2]=four_twocomp(P20,G20,bitand(a(2),b(2)),c1);
 pp30=bitand(a(4),b(1));
 pp03=bitand(a(1),b(4));
 pp21=bitand(a(3),b(2));
 pp12=bitand(a(2),b(3));
 P21= bitor(pp21,pp12);
 G21= bitand(pp21,pp12);
 P30= bitor(pp30,pp03);
 G30= bitand(pp30,pp03);
 GpG3021= bitor(G30,G21);
[p(4),c3]=four_twocomp(c2,GpG3021,P21,P30);
 pp31=bitand(a(4),b(2));
 pp13=bitand(a(2),b(4));
 P31=bitor(pp31,pp13);
 G31=bitand(pp31,pp13);
 pp22=bitand(a(3),b(3)); 
 [p(5),c4]=four_twocomp(P31,G31,pp22,c3);
 pp32=bitand(a(4),b(3));
pp23=bitand(a(3),b(4));
[p(6),c5]=fa(pp32,pp23,c4);
pp33=bitand(a(4),b(4));
[p(7),p(8)]=ha(pp33,c5);
end
