function [frec1,frec2] = notadoble(p)
disp(p)
if p == 22  
    frec1 = 659;
    frec2 = 587;
elseif p == 23 
    frec1 = 659;
    frec2 = 493;
elseif p == 24
    frec1 = 587;
    frec2 = 523;
elseif p == 25
    frec1 = 329;
    frec2 = 440;
elseif p == 26
    frec1 = 440;
    frec2 = 261;
elseif p == 27
    frec1 = 392;
    frec2 = 493;
elseif p == 28
    frec1 = 261;
    frec2 = 329;
elseif p == 29
    frec1 = 698;
    frec2 = 880;
elseif p == 30
    frec1 = 523;
    frec2 = 493;
elseif p == 31
    frec1 = 523;
    frec2 = 587;
end