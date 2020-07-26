function [class]=setLabel(ch) 

class=999;

         %setting class
            if strcmp(ch, 'o') || strcmp(ch, 'O') || strcmp(ch, '0')
               class=0;
            elseif strcmp(ch, '1') || strcmp(ch, 'i') || strcmp(ch, 'I') || strcmp(ch, 'l')
               class=1;
            elseif strcmp(ch, '2')
               class=2;
            elseif strcmp(ch, '3')
               class=3;
            elseif strcmp(ch, '4')
               class=4;
            elseif strcmp(ch, '5')
               class=5;
            elseif strcmp(ch, '6') || strcmp(ch, '9') 
               class=6;
            elseif strcmp(ch, '7') || strcmp(ch, 'L') 
               class=7;
            elseif strcmp(ch, '8')
               class=8;
            elseif strcmp(ch, 'a') 
               class=9;
            elseif strcmp(ch, 'b') || strcmp(ch, 'q')
               class=10;
            elseif strcmp(ch, 'c') || strcmp(ch, 'C')
               class=11;
            elseif strcmp(ch, 'd') || strcmp(ch, 'p') || strcmp(ch, 'P')
               class=12;
            elseif strcmp(ch, 'e')
               class=13;
            elseif strcmp(ch, 'f')
               class=14;
            elseif strcmp(ch, 'g')
               class=15;
            elseif strcmp(ch, 'h')
               class=16;
            elseif strcmp(ch, 'j') || strcmp(ch, 'J')
               class=17;
            elseif strcmp(ch, 'k')
               class=18;
            elseif strcmp(ch, 'm') || strcmp(ch, 'M') || strcmp(ch, 'w') || strcmp(ch, 'W')
               class=19;
            elseif strcmp(ch, 'n') || strcmp(ch, 'u') || strcmp(ch, 'U') 
               class=20;
            elseif strcmp(ch, 'r')
               class=21;
            elseif strcmp(ch, 's') || strcmp(ch, 'S')
               class=22;
            elseif strcmp(ch, 't')
               class=23;
            elseif strcmp(ch, 'v') || strcmp(ch, 'V')
               class=24;
            elseif strcmp(ch, 'x') || strcmp(ch, 'X')
               class=25;
            elseif strcmp(ch, 'y')
               class=26;
            elseif strcmp(ch, 'z') || strcmp(ch, 'Z') || strcmp(ch, 'N')   
               class=27;
            elseif strcmp(ch, 'A')
               class=28;
            elseif strcmp(ch, 'B')
               class=29;
            elseif strcmp(ch, 'D')
               class=30;
            elseif strcmp(ch, 'E')
               class=31;
            elseif strcmp(ch, 'F')
               class=32;
            elseif strcmp(ch, 'G')
               class=33;
            elseif strcmp(ch, 'H')
               class=34;
            elseif strcmp(ch, 'K')
               class=35;
            elseif strcmp(ch, 'Q')
               class=36;
            elseif strcmp(ch, 'R')
               class=37;
            elseif strcmp(ch, 'T')
               class=38;
            elseif strcmp(ch, 'Y')
               class=39;
            end
            if class== 999
              disp(ch);
            end
    