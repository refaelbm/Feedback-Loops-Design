clear all
clc

%% Main code
%% First input
X_amount = 2;
Y_amount = 2;
W_amount = 2;
Z_amount = 2;
Multiplication_amount = 0;
Addition_amount = X_amount + Y_amount + W_amount + Z_amount - 1;
Inverse_amount = 4;
BracketR_amount = 1;
BracketL_amount = 1;
bracket_counter = 0;

Amount_of_matmtical = Multiplication_amount + Addition_amount + Inverse_amount + BracketR_amount + BracketL_amount;
Total = X_amount + Y_amount + Multiplication_amount + Addition_amount + Inverse_amount + BracketR_amount + BracketL_amount + W_amount + Z_amount;


%% Creating the vector of rucrsie sets

Sets = CreatingSets(Total-1);

%% Creating a vector with all the input
Vector = zeros(1,Total);

X_amount_temp = X_amount;
Y_amount_temp = Y_amount;
W_amount_temp = W_amount;
Z_amount_temp = Z_amount;
Multiplication_amount_temp = Multiplication_amount;
Addition_amount_temp = Addition_amount;
Inverse_amount_temp = Inverse_amount;
BracketR_amount_temp = BracketR_amount;
BracketL_amount_temp = BracketL_amount;

for i = 1:Total
    if(X_amount_temp>0)
        Vector(i) = 'X' ;
        X_amount_temp = X_amount_temp - 1;
    elseif(Y_amount_temp>0)
        Vector(i) = 'Y' ;
        Y_amount_temp = Y_amount_temp - 1;
    elseif(W_amount_temp>0)
        Vector(i) = 'W' ;
        W_amount_temp = W_amount_temp - 1;
    elseif(Z_amount_temp>0)
        Vector(i) = 'Z' ;
        Z_amount_temp = Z_amount_temp - 1;
    elseif(Addition_amount_temp>0)
        Vector(i) = 'A' ;
        Addition_amount_temp = Addition_amount_temp - 1;
    elseif(Multiplication_amount_temp>0)
        Vector(i) = 'B' ;
        Multiplication_amount_temp = Multiplication_amount_temp - 1;
    elseif(Inverse_amount_temp>0)
        Vector(i) = 'C' ;
        Inverse_amount_temp = Inverse_amount_temp - 1;
    elseif(BracketL_amount_temp>0)
        Vector(i) = 'D' ;
        BracketL_amount_temp = BracketL_amount_temp - 1;
    elseif(BracketR_amount_temp>0)
        Vector(i) = 'E' ;
        BracketR_amount_temp = BracketR_amount_temp - 1;
    end
end

%% Test vecor of known function X+Y^-1+(W+Z^-1)^-1 = Phi(Phi(W,Z),Phi(X,Y))^-1 = (((W+Z^-1)^-1 + ((X+Y^-1)^-1)^-1)^-1)^-1
% Phi(X,Y) = (X+Y^-1)^-1
Test = zeros(1,Total);
Test(1) =  'X'  ;
Test(2) =  'A'  ;
Test(3) =  'Y'  ;
Test(4) =  'C'  ;
Test(5) =  'A'  ;
Test(6) =  'D'  ;
Test(7) =  'W'  ;
Test(8) =  'A'  ;
Test(9) =  'Z'  ;
Test(10) =  'C'  ;
Test(11) =  'E'  ;
Test(12) =  'C'  ;

tic %%%%%%

%% Function Generate with constrains
Counters = zeros(1,9);
for i = 1:Total
    if((Vector(i) == 'A' || Vector(i) == 'B' || Vector(i) == 'C' || Vector(i) == 'E')) % Array can't start with '+','*','^-1',')'
        continue ;
    end
    V = Vector(i);
    if(~RepetCondtion(V,Counters)) %To prevent returning on the same latter
        continue;
    end
    
    if(V == 'D') %  bracket_counter no need for ')' becuse that already drop at the first if
        bracket_counter = bracket_counter + 1 ;
    else
        bracket_counter = 0;
    end
    if(i==1)
        vector_temp = FunctionCreate(Vector(2:end),Total-1,V(1),Total,Test,bracket_counter);
    elseif(i==Total)
        vector_temp = FunctionCreate(Vector(1:end-1),Total-1,V(1),Total,Test,bracket_counter);
    else
        vector_temp = FunctionCreate([Vector(1:i-1) Vector(i+1:end)],Total-1,V(1),Total,Test,bracket_counter);
    end
    if(i==1) % First input
        function_gen = vector_temp;
    else
        function_gen = [function_gen ; vector_temp];
    end
    
    if(V == 'A')
        Counters(1)= 1;
    elseif (V == 'B')
        Counters(2)= 1;
    elseif (V == 'C')
        Counters(3)= 1;
    elseif (V == 'D')
        Counters(4)= 1;
    elseif (V == 'E')
        Counters(5)= 1;
    elseif (V == 'W')
        Counters(6)= 1;
    elseif (V == 'X')
        Counters(7)= 1;
    elseif (V == 'Y')
        Counters(8)= 1;
    elseif (V == 'Z')
        Counters(9)= 1;
    end
end

toc %%%%%%
%tic
%Try3 = function_gen;
%Try3( all(~Try3,2), :  ) = [] ;
%% Functions with out duplcte functions and with out the extra vectors that we added
%toc
tic

function_without_dup = function_gen;
function_without_dup( all(~function_without_dup,2), :  ) = [] ; %% Clear zeros row

toc

  function_without_dup1 = function_without_dup;
% 
% for i = 2:size(function_without_dup,1)
%     flag = 0;
%     for j = 1:size(function_without_dup1,1)
%         if(isequal(function_without_dup1(j,:),function_without_dup(i,:)))
%             flag = 1;
%             break;
%         end
%     end
%     if(flag == 0)
%        function_without_dup1(end+1,:) = function_without_dup(i,:);
%     end
% end
% function_without_dup2 = unique(function_without_dup,'rows'); %% Clear duplicate rows


tic
%% Taking only one type of function for example f(x,y) and delete f(y,x) when that the same function but diffrent virable spots
TheFunctions(1,:) = function_without_dup1(1,:);
Check_vector(1,:) = MatmticVector(function_without_dup1(1,:),Total,Multiplication_amount,Addition_amount,Inverse_amount,BracketR_amount,BracketL_amount);

for i = 2:size(function_without_dup1)
    flag = 1;
    Check_vector_temp = MatmticVector(function_without_dup1(i,:),Total,Multiplication_amount,Addition_amount,Inverse_amount,BracketR_amount,BracketL_amount);
    for j = 1:size(TheFunctions)
        if(isequal(Check_vector(j,:),Check_vector_temp))%Checking if we have the same function but diffrent varible spots
            flag = 0;
            break ;
        end
   end
   if(flag)
        TheFunctions = [TheFunctions ; function_without_dup1(i,:)];
        Check_vector = [Check_vector ; Check_vector_temp];
   end
end
toc

tic
%% Creating the string of the functions
temp = CreateStringMatrix(TheFunctions(1,:),Total);
TheFunctions_Strings(1,:) = temp;
for i=2:size(TheFunctions) %% Creting the string of the function into the metrix
    temp = CreateStringMatrix(TheFunctions(i,:),Total);
    TheFunctions_Strings = [TheFunctions_Strings ; temp];

end

toc
%% Creating the text filefor furter process

% [fileID,message] = fopen('Test.txt','wt');
% if(fileID<0)
%     disp(message);
% end
%
% for i = 1:size(TheFunctions)
%     fprintf(fileID,'%s\n',TheFunctions_Strings(i));
% end
% fclose(fileID);

%% Function to create our matrix string

function Vector = CreateStringMatrix(V,size)

for i=1:size
    if(V(i) == 'A')
        Char = '+';
        
    elseif(V(i) == 'B')
        Char = '*';
        
    elseif(V(i) == 'C')
        Char = '^-1';
        
    elseif(V(i) == 'D')
        Char = '(';
        
    elseif(V(i) == 'E')
        Char = ')';
        
    elseif(V(i) == 'X')
        Char = 'X';
        
    elseif(V(i) == 'Y')
        Char = 'Y';
        
    elseif(V(i) == 'Z')
        Char = 'Z';
        
    elseif(V(i) == 'W')
        Char = 'W';
        
    end
    if(i==1)% First char to the string
        Vector_temp(i) = Char;
    else
        Vector_temp = [Vector_temp Char];
    end
end
Vector = Vector_temp ;
end

%% Function to find the spot of '+','*','^-1','(',')' and create a new vector of data

function vector = MatmticVector(V,size,Multiplication_amount,Addition_amount,Inverse_amount,BracketR_amount,BracketL_amount)
vector = zeros(1,Multiplication_amount + Addition_amount + Inverse_amount + BracketR_amount + BracketL_amount+5);
vector(1) = 'A' ;
A_amount = 1;
B_amount = 1;
C_amount = 1;
D_amount = 1;
E_amount = 1;
for i=1:size
    if(V(i) == 'A')
        A(A_amount) = i;
        A_amount = A_amount + 1;
    elseif(V(i) == 'B')
        B(B_amount) = i;
        B_amount = B_amount + 1;
    elseif(V(i) == 'C')
        C(C_amount) = i;
        C_amount = C_amount + 1;
    elseif(V(i) == 'D')
        D(D_amount) = i;
        D_amount = D_amount + 1;
    elseif(V(i) == 'E')
        E(E_amount) = i;
        E_amount = E_amount + 1;
    end
end
if(A_amount == 1)
    A = 0;
    Addition_amount = 1;
end
if(B_amount == 1)
    B = 0;
    Multiplication_amount = 1;
end
if(C_amount == 1)
    C = 0;
    Inverse_amount = 1;
end
if(D_amount == 1)
    D = 0;
    BracketL_amount = 1;
end
if(E_amount == 1)
    E = 0;
    BracketR_amount = 1;
end
vector(2:2+Addition_amount-1)=A(:);
vector(2+Addition_amount)= 'B';
vector(2+Addition_amount+1:3+Addition_amount+Multiplication_amount-1)=B(:);
vector(3+Addition_amount+Multiplication_amount) = 'C' ;
vector(3+Addition_amount+Multiplication_amount+1:4+Addition_amount+Multiplication_amount+Inverse_amount-1)=C(:);
vector(4+Addition_amount+Multiplication_amount+Inverse_amount) = 'D' ;
vector(4+Addition_amount+Multiplication_amount+Inverse_amount+1:5+Addition_amount+Multiplication_amount+Inverse_amount+BracketL_amount-1)=D(:);
vector(5+Addition_amount+Multiplication_amount+Inverse_amount+BracketL_amount) = 'E' ;
vector(5+Addition_amount+Multiplication_amount+Inverse_amount+BracketL_amount+1:6+Addition_amount+Multiplication_amount+Inverse_amount+BracketL_amount+BracketR_amount-1)=E(:);
end

%% Checking for repeting virable of sgin
function check = RepetCondtion(V,Counter)
if(V == 'A' && Counter(1)>0)
    check = 0;
    return ;
elseif (V == 'B' && Counter(2)>0)
    check = 0;
    return ;
elseif (V == 'C' && Counter(3)>0)
    check = 0;
    return ;
elseif (V == 'D' && Counter(4)>0)
    check = 0;
    return ;
elseif (V == 'E' && Counter(5)>0)
    check = 0;
    return ;
elseif (V == 'W' && Counter(6)>0)
    check = 0;
    return ;
elseif (V == 'X' && Counter(7)>0)
    check = 0;
    return ;
elseif (V == 'Y' && Counter(8)>0)
    check = 0;
    return ;
elseif (V == 'Z' && Counter(9)>0)
    check = 0;
    return ;
end
check = 1;
end

function Set = CreatingSets(Total)

if(Total == 0)
    Set = 0;
    return;
end
if(Total <= 2 && (Total >= 1) || Total < 0)
    Set = -1;
    return;
end


Check = CreatingSets(Total - 6);
if(size(Check,2) == 1)
    if(Check == -1)
        Set = -1;
    elseif(Check == 0)
        Set = 6;
        return ;
    elseif(Check > 0)
        Set = [ 6 Check ] ;
        return ;
    end
elseif(size(Check,2) > 1)
    Set = [ 6 Check ] ;
    return ;
end

Check = CreatingSets(Total - 5);
if(size(Check,2) == 1)
    if(Check == -1)
        Set = -1;
    elseif(Check == 0)
        Set = 5;
        return ;
    elseif(Check > 0)
        Set = [ 5 Check ] ;
        return ;
    end
elseif(size(Check,2) > 1)
    Set = [ 5 Check ] ;
    return ;
end

Check = CreatingSets(Total - 4);
if(size(Check,2) == 1)
    if(Check == -1)
        Set = -1;
    elseif(Check == 0)
        Set = 4;
        return ;
    elseif(Check > 0)
        Set = [ 4 Check ] ;
        return ;
    end
elseif(size(Check,2) > 1)
    Set = [ 4 Check ] ;
    return ;
end

Check = CreatingSets(Total - 3);
if(size(Check,2) == 1)
    if(Check == -1)
        Set = -1;
    elseif(Check == 0)
        Set = 3;
        return ;
    elseif(Check > 0)
        Set = [ 3 Check ] ;
        return ;
    end
elseif(size(Check,2) > 1)
    Set = [ 3 Check ] ;
    return ;
end

end