function [letter]=setChar(class) 

letter=999;

%setting character
            if class==0
               letter='0';
            elseif class==1
               letter='1';
            elseif class==2
               letter='2';
            elseif class==3
               letter='3';
            elseif class==4
               letter='4';
            elseif class==5
               letter='5';
            elseif class==6
               letter='6';
            elseif class==7
               letter='7';
            elseif class==8
               letter='8';
            elseif class==9
               letter='a';
            elseif class==10
               letter='b';
            elseif class==11
               letter='c';
            elseif class==12
               letter='d';
            elseif class==13
               letter='e';
            elseif class==14
               letter='f';
            elseif class==15
               letter='g';
            elseif class==16
               letter='h';
            elseif class==17
               letter='j';
            elseif class==18
               letter='k';
            elseif class==19
               letter='m';
            elseif class==20
               letter='n';
            elseif class==21
               letter='r';
            elseif class==22
               letter='s';
            elseif class==23
               letter='t';
            elseif class==24
               letter='v';
            elseif class==25
               letter='x';
            elseif class==26
               letter='y';
            elseif class==27
               letter='z';
            elseif class==28
               letter='A';
            elseif class==29
               letter='B';
            elseif class==30
               letter='D';
            elseif class==31
               letter='E';
            elseif class==32
               letter='F';
            elseif class==33
               letter='G';
            elseif class==34
               letter='H';
            elseif class==35
               letter='K';
            elseif class==36
               letter='Q';
            elseif class==37
               letter='R';
            elseif class==38
               letter='T';
            elseif class==39
               letter='Y';
            end
            if letter== 999
              disp(letter);
              exit;
            end
