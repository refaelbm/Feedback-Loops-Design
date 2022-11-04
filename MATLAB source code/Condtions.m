clear all
clc

%% Main code
%% First input
X_amount = 1;
Y_amount = 1;
W_amount = 1;
Z_amount = 0;
Multiplication_amount = 0;
Addition_amount = 2;
Inverse_amount = 2;
BracketR_amount = 0;
BracketL_amount = 0;
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

%% Function Generate with constrains
Counters = zeros(1,9);
if(size(Sets)==1)
    Sets = [Sets 0];
end
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
    if(Sets(1) == 3)
        if(i==1)
            vector_temp = FunctionCreate3(Vector(2:end),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        elseif(i==Total)
            vector_temp = FunctionCreate3(Vector(1:end-1),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        else
            vector_temp = FunctionCreate3([Vector(1:i-1) Vector(i+1:end)],Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        end
    elseif(Sets(1) == 4)
        if(i==1)
            vector_temp = FunctionCreate4(Vector(2:end),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        elseif(i==Total)
            vector_temp = FunctionCreate4(Vector(1:end-1),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        else
            vector_temp = FunctionCreate4([Vector(1:i-1) Vector(i+1:end)],Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        end
    elseif(Sets(1) == 5)
        if(i==1)
            vector_temp = FunctionCreate5(Vector(2:end),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        elseif(i==Total)
            vector_temp = FunctionCreate5(Vector(1:end-1),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        else
            vector_temp = FunctionCreate5([Vector(1:i-1) Vector(i+1:end)],Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        end
    else
        if(i==1)
            vector_temp = FunctionCreate6(Vector(2:end),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        elseif(i==Total)
            vector_temp = FunctionCreate6(Vector(1:end-1),Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        else
            vector_temp = FunctionCreate6([Vector(1:i-1) Vector(i+1:end)],Total-1,V(1),Total,Test,bracket_counter,Sets(2:end));
        end
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
Try3 = function_gen;
Try3( all(~Try3,2), :  ) = [] ;
%% Functions with out duplcte functions and with out the extra vectors that we added

function_without_dup = function_gen;
function_without_dup( all(~function_without_dup,2), :  ) = [] ; %% Clear zeros row
function_without_dup = unique(function_without_dup,'rows'); %% Clear duplicate rows

%% Taking only one type of function for example f(x,y) and delete f(y,x) when that the same function but diffrent virable spots

for i = 1:size(function_without_dup)
    flag = 1;
    if(i==1)
        TheFunctions = function_without_dup(i,:);
        Check_vector(1,:) = MatmticVector(function_without_dup(i,:),Total,Multiplication_amount,Addition_amount,Inverse_amount,BracketR_amount,BracketL_amount);
        continue;
    else
        Check_vector_temp = MatmticVector(function_without_dup(i,:),Total,Multiplication_amount,Addition_amount,Inverse_amount,BracketR_amount,BracketL_amount);
        for j = 1:size(TheFunctions)
            if(isequal(Check_vector(j,:),Check_vector_temp))%Checking if we have the same function but diffrent varible spots
                flag = 0;
                break ;
            end
        end
        if(flag)
            TheFunctions = [TheFunctions ; function_without_dup(i,:)];
            Check_vector = [Check_vector ; Check_vector_temp];
        end
    end
end

%% Creating the string of the functions

for i=1:size(TheFunctions) %% Creting the string of the function into the metrix
    temp = CreateStringMatrix(TheFunctions(i,:),Total);
    if(i==1)
        TheFunctions_Strings = temp;
    else
        TheFunctions_Strings = [TheFunctions_Strings ; temp];
    end
end

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

function VectorCreate = FunctionCreate3(Vector,Total,V,Size,Test,bracket_counter,Sets)
if(Total == 0)
    VectorCreate = V;
    %       if(V == Test)
    %           s=1;
    %       end
    return ;
end
flag = 0;
Breket_temp = bracket_counter ;
Counters = zeros(3,9);
for i = 1:Total
    if(~RepetCondtion(Vector(i),Counters(1,:))) %To prevent returning on the same latter
        continue;
    end
    % Breket  counter if
    if(Vector(i) == 'D')
        Breket_temp = Breket_temp + 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp - 1;
    else
        Breket_temp = bracket_counter ;
    end
    
    if(Condtion(V(end),V,Vector(i),Breket_temp,Total) == 0)
        if(Vector(i) == 'D')% Breket  counter updtae if becuse we have the continue function
            Breket_temp = Breket_temp - 1;
        elseif(Vector(i) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        continue ;
    end
    if(i==1) %Checking if we at the start of the for
        if(Total>1) % Checking if we at the last recursie
            vector1 = Vector(2:end);
        else
            vector1 = Vector(end);% we at the last recursie
        end
    elseif(i<Total) % Checking if we at the end of if
        vector1 = [Vector(1:i-1) Vector(i+1:end)];
    else
        vector1 = Vector(1:i-1);
    end
    
    for j = 1:Total-1
        if(~RepetCondtion(vector1(j),Counters(2,:))) %To prevent returning on the same latter
            continue;
        end
        % Breket  counter if
        if(vector1(j) == 'D')
            Breket_temp = Breket_temp + 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp - 1;
        else
            Breket_temp = bracket_counter ;
        end
        
        if(Condtion(Vector(i),[V Vector(i)],vector1(j),Breket_temp,Total) == 0)
            if(vector1(j) == 'D')% Breket  counter updtae if becuse we have the continue function
                Breket_temp = Breket_temp - 1;
            elseif(vector1(j) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            continue ;
        end
        if(j==1) %Checking if we at the start of the for
            if(Total>1) % Checking if we at the last recursie
                vector2 = vector1(2:end);
            else
                vector2 = vector1(end);% we at the last recursie
            end
        elseif(j<Total) % Checking if we at the end of if
            vector2 = [vector1(1:j-1) vector1(j+1:end)];
        else
            vector2 = vector1(1:j-1);
        end
        
        for k = 1:Total-2
            if(~RepetCondtion(vector2(k),Counters(3,:))) %To prevent returning on the same latter
                continue;
            end
            % Breket  counter if
            if(vector2(k) == 'D')
                Breket_temp = Breket_temp + 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp - 1;
            else
                Breket_temp = bracket_counter ;
            end
            
            if(Condtion(vector1(j),[V Vector(i) vector2(k)],vector2(k),Breket_temp,Total) == 0)
                if(vector2(k) == 'D')% Breket  counter updtae if becuse we have the continue function
                    Breket_temp = Breket_temp - 1;
                elseif(vector2(k) == 'E')
                    Breket_temp = Breket_temp + 1;
                end
                continue ;
            end
            if(k==1) %Checking if we at the start of the for
                if(Total>1) % Checking if we at the last recursie
                    vector3 = FunctionCreate3(vector2(2:end),Total-3,[V Vector(i) vector1(j) vector2(k)],Size,Test,bracket_counter,Sets);
                else
                    vector3 = FunctionCreate3(vector2(end),Total-3,[V Vector(i) vector1(j) vector2(k)],Size,Test,bracket_counter,Sets);% we at the last recursie
                end
            elseif(k<Total) % Checking if we at the end of if
                vector3 = FunctionCreate3([vector2(1:k-1) vector2(k+1:end)],Total-3,[V Vector(i) vector1(j) vector2(k)],Size,Test,bracket_counter,Sets);
            else
                vector3 = FunctionCreate3(vector2(1:k-1),Total-3,[V Vector(i) vector1(j) vector2(k)],Size,Test,bracket_counter,Sets);
            end
            
            if(flag==0)
                vector_end = vector3;
                flag = 1;
            else
                vector_end = [vector_end ; vector3];
            end
            
            if(vector2(k) == 'D')% Breket  counter if restore
                Breket_temp = Breket_temp - 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            
            if(vector1(j) == 'A')
                Counters(3,1)= 1;
            elseif (vector2(k) == 'B')
                Counters(3,2)= 1;
            elseif (vector2(k) == 'C')
                Counters(3,3)= 1;
            elseif (vector2(k) == 'D')
                Counters(3,4)= 1;
            elseif (vector2(k) == 'E')
                Counters(3,5)= 1;
            elseif (vector2(k) == 'W')
                Counters(3,6)= 1;
            elseif (vector2(k) == 'X')
                Counters(3,7)= 1;
            elseif (vector2(k) == 'Y')
                Counters(3,8)= 1;
            elseif (vector2(k) == 'Z')
                Counters(3,9)= 1;
            end
        end
        
        if(vector1(j) == 'D')% Breket  counter if restore
            Breket_temp = Breket_temp - 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        
        if(vector1(j) == 'A')
            Counters(2,1)= 1;
        elseif (vector1(j) == 'B')
            Counters(2,2)= 1;
        elseif (vector1(j) == 'C')
            Counters(2,3)= 1;
        elseif (vector1(j) == 'D')
            Counters(2,4)= 1;
        elseif (vector1(j) == 'E')
            Counters(2,5)= 1;
        elseif (vector1(j) == 'W')
            Counters(2,6)= 1;
        elseif (vector1(j) == 'X')
            Counters(2,7)= 1;
        elseif (vector1(j) == 'Y')
            Counters(2,8)= 1;
        elseif (vector1(j) == 'Z')
            Counters(2,9)= 1;
        end
    end
    
    
    
    if(Vector(i) == 'D')% Breket  counter if restore
        Breket_temp = Breket_temp - 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp + 1;
    end
    if(Vector(i) == 'A')
        Counters(1,1)= 1;
    elseif (Vector(i) == 'B')
        Counters(1,2)= 1;
    elseif (Vector(i) == 'C')
        Counters(1,3)= 1;
    elseif (Vector(i) == 'D')
        Counters(1,4)= 1;
    elseif (Vector(i) == 'E')
        Counters(1,5)= 1;
    elseif (Vector(i) == 'W')
        Counters(1,6)= 1;
    elseif (Vector(i) == 'X')
        Counters(1,7)= 1;
    elseif (Vector(i) == 'Y')
        Counters(1,8)= 1;
    elseif (Vector(i) == 'Z')
        Counters(1,9)= 1;
    end
end

if(flag==0) % If we didn't got any vector we need to send somthing
        VectorCreate = zeros(1,Size);
    else
        VectorCreate = vector_end ;
    end

end

%% Function4
function VectorCreate = FunctionCreate4(Vector,Total,V,Size,Test,bracket_counter,Sets)
if(Total == 0)
    VectorCreate = V;
    %       if(V == Test)
    %           s=1;
    %       end
    return ;
end
if(size(Sets)==1)
    Sets = [Sets 0];
end
flag = 0;
Breket_temp = bracket_counter ;
Counters = zeros(4,9);
for i = 1:Total
    if(~RepetCondtion(Vector(i),Counters(1,:))) %To prevent returning on the same latter
        continue;
    end
    % Breket  counter if
    if(Vector(i) == 'D')
        Breket_temp = Breket_temp + 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp - 1;
    else
        Breket_temp = bracket_counter ;
    end
    
    if(Condtion(V(end),V,Vector(i),Breket_temp,Total) == 0)
        if(Vector(i) == 'D')% Breket  counter updtae if becuse we have the continue function
            Breket_temp = Breket_temp - 1;
        elseif(Vector(i) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        continue ;
    end
    if(i==1) %Checking if we at the start of the for
        if(Total>1) % Checking if we at the last recursie
            vector1 = Vector(2:end);
        else
            vector1 = Vector(end);% we at the last recursie
        end
    elseif(i<Total) % Checking if we at the end of if
        vector1 = [Vector(1:i-1) Vector(i+1:end)];
    else
        vector1 = Vector(1:i-1);
    end
    
    for j = 1:Total-1
        if(~RepetCondtion(vector1(j),Counters(2,:))) %To prevent returning on the same latter
            continue;
        end
        % Breket  counter if
        if(vector1(j) == 'D')
            Breket_temp = Breket_temp + 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp - 1;
        else
            Breket_temp = bracket_counter ;
        end
        
        if(Condtion(Vector(i),[V Vector(i)],vector1(j),Breket_temp,Total) == 0)
            if(vector1(j) == 'D')% Breket  counter updtae if becuse we have the continue function
                Breket_temp = Breket_temp - 1;
            elseif(vector1(j) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            continue ;
        end
        if(j==1) %Checking if we at the start of the for
            if(Total>1) % Checking if we at the last recursie
                vector2 = vector1(2:end);
            else
                vector2 = vector1(end);% we at the last recursie
            end
        elseif(j<Total) % Checking if we at the end of if
            vector2 = [vector1(1:j-1) vector1(j+1:end)];
        else
            vector2 = vector1(1:j-1);
        end
        
        for k = 1:Total-2
            if(~RepetCondtion(vector2(k),Counters(3,:))) %To prevent returning on the same latter
                continue;
            end
            % Breket  counter if
            if(vector2(k) == 'D')
                Breket_temp = Breket_temp + 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp - 1;
            else
                Breket_temp = bracket_counter ;
            end
            
            if(Condtion(vector1(j),[V Vector(i) vector2(k)],vector2(k),Breket_temp,Total) == 0)
                if(vector2(k) == 'D')% Breket  counter updtae if becuse we have the continue function
                    Breket_temp = Breket_temp - 1;
                elseif(vector2(k) == 'E')
                    Breket_temp = Breket_temp + 1;
                end
                continue ;
            end
            if(k==1) %Checking if we at the start of the for
                if(Total>1) % Checking if we at the last recursie
                    vector3 = vector2(2:end);
                else
                    vector3 = vector2(end);% we at the last recursie
                end
            elseif(k<Total) % Checking if we at the end of if
                vector3 = [vector2(1:k-1) vector2(k+1:end)];
            else
                vector3 = vector2(1:k-1);
            end
            
            for m = 1: Total - 3
                if(~RepetCondtion(vector3(m),Counters(4,:))) %To prevent returning on the same latter
                    continue;
                end
                % Breket  counter if
                if(vector3(m) == 'D')
                    Breket_temp = Breket_temp + 1;
                elseif(vector3(m) == 'E')
                    Breket_temp = Breket_temp - 1;
                else
                    Breket_temp = bracket_counter ;
                end
                
                if(Condtion(vector2(k),[V Vector(i) vector2(k) vector3(m)],vector3(m),Breket_temp,Total) == 0)
                    if(vector3(m) == 'D')% Breket  counter updtae if becuse we have the continue function
                        Breket_temp = Breket_temp - 1;
                    elseif(vector3(m) == 'E')
                        Breket_temp = Breket_temp + 1;
                    end
                    continue ;
                end
                if(Sets(1) == 3)
                    if(m==1) %Checking if we at the start of the for
                        if(Total>1) % Checking if we at the last recursie
                            vector4 = FunctionCreate3(vector3(2:end),Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets);
                        else
                            vector4 = FunctionCreate3(vector3(end),Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets);% we at the last recursie
                        end
                    elseif(j<Total) % Checking if we at the end of if
                        vector4 = FunctionCreate3([vector3(1:k-1) vector3(k+1:end)],Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets);
                    else
                        vector4 = FunctionCreate3(vector3(1:k-1),Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets);
                    end
                else
                    if(m==1) %Checking if we at the start of the for
                        if(Total>1) % Checking if we at the last recursie
                            vector4 = FunctionCreate4(vector3(2:end),Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets(2:end));
                        else
                            vector4 = FunctionCreate4(vector3(end),Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                        end
                    elseif(j<Total) % Checking if we at the end of if
                        vector4 = FunctionCreate4([vector3(1:m-1) vector3(m+1:end)],Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets(2:end));
                    else
                        vector4 = FunctionCreate4(vector3(1:m-1),Total-4,[V Vector(i) vector1(j) vector2(k) vector3(m)],Size,Test,bracket_counter,Sets(2:end));
                    end
                end
                
                if(flag==0)
                    vector_end = vector4;
                    flag = 1;
                else
                    vector_end = [vector_end ; vector4];
                end
                
                if(vector3(m) == 'D')% Breket  counter if restore
                    Breket_temp = Breket_temp - 1;
                elseif(vector3(m) == 'E')
                    Breket_temp = Breket_temp + 1;
                end
                
                if(vector3(m) == 'A')
                    Counters(4,1)= 1;
                elseif (vector3(m) == 'B')
                    Counters(4,2)= 1;
                elseif (vector3(m) == 'C')
                    Counters(4,3)= 1;
                elseif (vector3(m) == 'D')
                    Counters(4,4)= 1;
                elseif (vector3(m) == 'E')
                    Counters(4,5)= 1;
                elseif (vector3(m) == 'W')
                    Counters(4,6)= 1;
                elseif (vector3(m) == 'X')
                    Counters(4,7)= 1;
                elseif (vector3(m) == 'Y')
                    Counters(4,8)= 1;
                elseif (vector3(m) == 'Z')
                    Counters(4,9)= 1;
                end
            end
            
            if(vector2(k) == 'D')% Breket  counter if restore
                Breket_temp = Breket_temp - 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            
            if(vector2(k) == 'A')
                Counters(3,1)= 1;
            elseif (vector2(k) == 'B')
                Counters(3,2)= 1;
            elseif (vector2(k) == 'C')
                Counters(3,3)= 1;
            elseif (vector2(k) == 'D')
                Counters(3,4)= 1;
            elseif (vector2(k) == 'E')
                Counters(3,5)= 1;
            elseif (vector2(k) == 'W')
                Counters(3,6)= 1;
            elseif (vector2(k) == 'X')
                Counters(3,7)= 1;
            elseif (vector2(k) == 'Y')
                Counters(3,8)= 1;
            elseif (vector2(k) == 'Z')
                Counters(3,9)= 1;
            end
        end
        
        if(vector1(j) == 'D')% Breket  counter if restore
            Breket_temp = Breket_temp - 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        
        if(vector1(j) == 'A')
            Counters(2,1)= 1;
        elseif (vector1(j) == 'B')
            Counters(2,2)= 1;
        elseif (vector1(j) == 'C')
            Counters(2,3)= 1;
        elseif (vector1(j) == 'D')
            Counters(2,4)= 1;
        elseif (vector1(j) == 'E')
            Counters(2,5)= 1;
        elseif (vector1(j) == 'W')
            Counters(2,6)= 1;
        elseif (vector1(j) == 'X')
            Counters(2,7)= 1;
        elseif (vector1(j) == 'Y')
            Counters(2,8)= 1;
        elseif (vector1(j) == 'Z')
            Counters(2,9)= 1;
        end
    end
    
    
    
    if(Vector(i) == 'D')% Breket  counter if restore
        Breket_temp = Breket_temp - 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp + 1;
    end
    if(Vector(i) == 'A')
        Counters(1,1)= 1;
    elseif (Vector(i) == 'B')
        Counters(1,2)= 1;
    elseif (Vector(i) == 'C')
        Counters(1,3)= 1;
    elseif (Vector(i) == 'D')
        Counters(1,4)= 1;
    elseif (Vector(i) == 'E')
        Counters(1,5)= 1;
    elseif (Vector(i) == 'W')
        Counters(1,6)= 1;
    elseif (Vector(i) == 'X')
        Counters(1,7)= 1;
    elseif (Vector(i) == 'Y')
        Counters(1,8)= 1;
    elseif (Vector(i) == 'Z')
        Counters(1,9)= 1;
    end
end

if(flag==0) % If we didn't got any vector we need to send somthing
        VectorCreate = zeros(1,Size);
    else
        VectorCreate = vector_end ;
    end

end

%% Function5
function VectorCreate = FunctionCreate5(Vector,Total,V,Size,Test,bracket_counter,Sets)
if(Total == 0)
    VectorCreate = V;
    %       if(V == Test)
    %           s=1;
    %       end
    return ;
end
if(size(Sets)==1)
    Sets = [Sets 0];
end
flag = 0;
Breket_temp = bracket_counter ;
Counters = zeros(5,9);
for i = 1:Total
    if(~RepetCondtion(Vector(i),Counters(1,:))) %To prevent returning on the same latter
        continue;
    end
    % Breket  counter if
    if(Vector(i) == 'D')
        Breket_temp = Breket_temp + 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp - 1;
    else
        Breket_temp = bracket_counter ;
    end
    
    if(Condtion(V(end),V,Vector(i),Breket_temp,Total) == 0)
        if(Vector(i) == 'D')% Breket  counter updtae if becuse we have the continue function
            Breket_temp = Breket_temp - 1;
        elseif(Vector(i) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        continue ;
    end
    if(i==1) %Checking if we at the start of the for
        if(Total>1) % Checking if we at the last recursie
            vector1 = Vector(2:end);
        else
            vector1 = Vector(end);% we at the last recursie
        end
    elseif(i<Total) % Checking if we at the end of if
        vector1 = [Vector(1:i-1) Vector(i+1:end)];
    else
        vector1 = Vector(1:i-1);
    end
    
    for j = 1:Total-1
        if(~RepetCondtion(vector1(j),Counters(2,:))) %To prevent returning on the same latter
            continue;
        end
        % Breket  counter if
        if(vector1(j) == 'D')
            Breket_temp = Breket_temp + 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp - 1;
        else
            Breket_temp = bracket_counter ;
        end
        
        if(Condtion(Vector(i),[V Vector(i)],vector1(j),Breket_temp,Total) == 0)
            if(vector1(j) == 'D')% Breket  counter updtae if becuse we have the continue function
                Breket_temp = Breket_temp - 1;
            elseif(vector1(j) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            continue ;
        end
        if(j==1) %Checking if we at the start of the for
            if(Total>1) % Checking if we at the last recursie
                vector2 = vector1(2:end);
            else
                vector2 = vector1(end);% we at the last recursie
            end
        elseif(j<Total) % Checking if we at the end of if
            vector2 = [vector1(1:j-1) vector1(j+1:end)];
        else
            vector2 = vector1(1:j-1);
        end
        
        for k = 1:Total-2
            if(~RepetCondtion(vector2(k),Counters(3,:))) %To prevent returning on the same latter
                continue;
            end
            % Breket  counter if
            if(vector2(k) == 'D')
                Breket_temp = Breket_temp + 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp - 1;
            else
                Breket_temp = bracket_counter ;
            end
            
            if(Condtion(vector1(j),[V Vector(i) vector2(k)],vector2(k),Breket_temp,Total) == 0)
                if(vector2(k) == 'D')% Breket  counter updtae if becuse we have the continue function
                    Breket_temp = Breket_temp - 1;
                elseif(vector2(k) == 'E')
                    Breket_temp = Breket_temp + 1;
                end
                continue ;
            end
            if(k==1) %Checking if we at the start of the for
                if(Total>1) % Checking if we at the last recursie
                    vector3 = vector2(2:end);
                else
                    vector3 = vector2(end);% we at the last recursie
                end
            elseif(k<Total) % Checking if we at the end of if
                vector3 = [vector2(1:k-1) vector2(k+1:end)];
            else
                vector3 = vector2(1:k-1);
            end
            
            for m = 1: Total - 3
                if(~RepetCondtion(vector3(m),Counters(4,:))) %To prevent returning on the same latter
                    continue;
                end
                % Breket  counter if
                if(vector3(m) == 'D')
                    Breket_temp = Breket_temp + 1;
                elseif(vector3(m) == 'E')
                    Breket_temp = Breket_temp - 1;
                else
                    Breket_temp = bracket_counter ;
                end
                
                if(Condtion(vector2(k),[V Vector(i) vector2(k) vector3(m)],vector3(m),Breket_temp,Total) == 0)
                    if(vector3(m) == 'D')% Breket  counter updtae if becuse we have the continue function
                        Breket_temp = Breket_temp - 1;
                    elseif(vector3(m) == 'E')
                        Breket_temp = Breket_temp + 1;
                    end
                    continue ;
                end
                if(m==1) %Checking if we at the start of the for
                    if(Total>1) % Checking if we at the last recursie
                        vector4 = vector3(2:end);
                    else
                        vector4 = vector3(end);% we at the last recursie
                    end
                elseif(m<Total) % Checking if we at the end of if
                    vector4 = [vector3(1:k-1) vector3(k+1:end)];
                else
                    vector4 = vector3(1:k-1);
                end
                
                for n = 1:Total-4
                    if(~RepetCondtion(vector4(n),Counters(5,:))) %To prevent returning on the same latter
                        continue;
                    end
                    % Breket  counter if
                    if(vector4(n) == 'D')
                        Breket_temp = Breket_temp + 1;
                    elseif(vector4(n) == 'E')
                        Breket_temp = Breket_temp - 1;
                    else
                        Breket_temp = bracket_counter ;
                    end
                    
                    if(Condtion(vector3(m),[V Vector(i) vector2(k) vector3(m) vector4(n)],vector4(n),Breket_temp,Total) == 0)
                        if(vector4(n) == 'D')% Breket  counter updtae if becuse we have the continue function
                            Breket_temp = Breket_temp - 1;
                        elseif(vector4(n) == 'E')
                            Breket_temp = Breket_temp + 1;
                        end
                        continue ;
                    end
                    if(Sets(1) == 3)
                        if(n==1) %Checking if we at the start of the for
                            if(Total>1) % Checking if we at the last recursie
                                vector5 = FunctionCreate3(vector4(2:end),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            else
                                vector5 = FunctionCreate3(vector4(end),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                            end
                        elseif(n<Total) % Checking if we at the end of if
                            vector5 = FunctionCreate3([vector4(1:k-1) vector4(k+1:end)],Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                        else
                            vector5 = FunctionCreate3(vector4(1:k-1),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                        end
                    elseif(Sets(1) == 4)
                        if(n==1) %Checking if we at the start of the for
                            if(Total>1) % Checking if we at the last recursie
                                vector5 = FunctionCreate4(vector4(2:end),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            else
                                vector5 = FunctionCreate4(vector4(end),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                            end
                        elseif(n<Total) % Checking if we at the end of if
                            vector5 = FunctionCreate4([vector4(1:k-1) vector4(k+1:end)],Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                        else
                            vector5 = FunctionCreate4(vector4(1:k-1),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                        end
                    else
                        if(n==1) %Checking if we at the start of the for
                            if(Total>1) % Checking if we at the last recursie
                                vector5 = FunctionCreate5(vector4(2:end),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            else
                                vector5 = FunctionCreate5(vector4(end),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                            end
                        elseif(n<Total) % Checking if we at the end of if
                            vector5 = FunctionCreate5([vector4(1:k-1) vector4(k+1:end)],Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                        else
                            vector5 = FunctionCreate5(vector4(1:k-1),Total-5,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                        end
                    end
                    
                    if(flag==0)
                        vector_end = vector5;
                        flag = 1;
                    else
                        vector_end = [vector_end ; vector5];
                    end
                    
                    if(vector4(n) == 'D')% Breket  counter if restore
                        Breket_temp = Breket_temp - 1;
                    elseif(vector4(n) == 'E')
                        Breket_temp = Breket_temp + 1;
                    end
                    
                    if(vector4(n) == 'A')
                        Counters(5,1)= 1;
                    elseif (vector4(n) == 'B')
                        Counters(5,2)= 1;
                    elseif (vector4(n) == 'C')
                        Counters(5,3)= 1;
                    elseif (vector4(n) == 'D')
                        Counters(5,4)= 1;
                    elseif (vector4(n) == 'E')
                        Counters(5,5)= 1;
                    elseif (vector3(m) == 'W')
                        Counters(5,6)= 1;
                    elseif (vector4(n) == 'X')
                        Counters(5,7)= 1;
                    elseif (vector4(n) == 'Y')
                        Counters(5,8)= 1;
                    elseif (vector4(n) == 'Z')
                        Counters(5,9)= 1;
                    end
                end
                
                if(vector3(m) == 'D')% Breket  counter if restore
                    Breket_temp = Breket_temp - 1;
                elseif(vector3(m) == 'E')
                    Breket_temp = Breket_temp + 1;
                end
                
                if(vector3(m) == 'A')
                    Counters(4,1)= 1;
                elseif (vector3(m) == 'B')
                    Counters(4,2)= 1;
                elseif (vector3(m) == 'C')
                    Counters(4,3)= 1;
                elseif (vector3(m) == 'D')
                    Counters(4,4)= 1;
                elseif (vector3(m) == 'E')
                    Counters(4,5)= 1;
                elseif (vector3(m) == 'W')
                    Counters(4,6)= 1;
                elseif (vector3(m) == 'X')
                    Counters(4,7)= 1;
                elseif (vector3(m) == 'Y')
                    Counters(4,8)= 1;
                elseif (vector3(m) == 'Z')
                    Counters(4,9)= 1;
                end
            end
            
            if(vector2(k) == 'D')% Breket  counter if restore
                Breket_temp = Breket_temp - 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            
            if(vector2(k) == 'A')
                Counters(3,1)= 1;
            elseif (vector2(k) == 'B')
                Counters(3,2)= 1;
            elseif (vector2(k) == 'C')
                Counters(3,3)= 1;
            elseif (vector2(k) == 'D')
                Counters(3,4)= 1;
            elseif (vector2(k) == 'E')
                Counters(3,5)= 1;
            elseif (vector2(k) == 'W')
                Counters(3,6)= 1;
            elseif (vector2(k) == 'X')
                Counters(3,7)= 1;
            elseif (vector2(k) == 'Y')
                Counters(3,8)= 1;
            elseif (vector2(k) == 'Z')
                Counters(3,9)= 1;
            end
        end
        
        if(vector1(j) == 'D')% Breket  counter if restore
            Breket_temp = Breket_temp - 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        
        if(vector1(j) == 'A')
            Counters(2,1)= 1;
        elseif (vector1(j) == 'B')
            Counters(2,2)= 1;
        elseif (vector1(j) == 'C')
            Counters(2,3)= 1;
        elseif (vector1(j) == 'D')
            Counters(2,4)= 1;
        elseif (vector1(j) == 'E')
            Counters(2,5)= 1;
        elseif (vector1(j) == 'W')
            Counters(2,6)= 1;
        elseif (vector1(j) == 'X')
            Counters(2,7)= 1;
        elseif (vector1(j) == 'Y')
            Counters(2,8)= 1;
        elseif (vector1(j) == 'Z')
            Counters(2,9)= 1;
        end
    end
    
    
    
    if(Vector(i) == 'D')% Breket  counter if restore
        Breket_temp = Breket_temp - 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp + 1;
    end
    if(Vector(i) == 'A')
        Counters(1,1)= 1;
    elseif (Vector(i) == 'B')
        Counters(1,2)= 1;
    elseif (Vector(i) == 'C')
        Counters(1,3)= 1;
    elseif (Vector(i) == 'D')
        Counters(1,4)= 1;
    elseif (Vector(i) == 'E')
        Counters(1,5)= 1;
    elseif (Vector(i) == 'W')
        Counters(1,6)= 1;
    elseif (Vector(i) == 'X')
        Counters(1,7)= 1;
    elseif (Vector(i) == 'Y')
        Counters(1,8)= 1;
    elseif (Vector(i) == 'Z')
        Counters(1,9)= 1;
    end
end

if(flag==0) % If we didn't got any vector we need to send somthing
        VectorCreate = zeros(1,Size);
    else
        VectorCreate = vector_end ;
    end

end

%% Function6
function VectorCreate = FunctionCreate6(Vector,Total,V,Size,Test,bracket_counter,Sets)
if(Total == 0)
    VectorCreate = V;
    %       if(V == Test)
    %           s=1;
    %       end
    return ;
end
if(size(Sets)==1)
    Sets = [Sets 0];
end
flag = 0;
Breket_temp = bracket_counter ;
Counters = zeros(6,9);
for i = 1:Total
    if(~RepetCondtion(Vector(i),Counters(1,:))) %To prevent returning on the same latter
        continue;
    end
    % Breket  counter if
    if(Vector(i) == 'D')
        Breket_temp = Breket_temp + 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp - 1;
    else
        Breket_temp = bracket_counter ;
    end
    
    if(Condtion(V(end),V,Vector(i),Breket_temp,Total) == 0)
        if(Vector(i) == 'D')% Breket  counter updtae if becuse we have the continue function
            Breket_temp = Breket_temp - 1;
        elseif(Vector(i) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        continue ;
    end
    if(i==1) %Checking if we at the start of the for
        if(Total>1) % Checking if we at the last recursie
            vector1 = Vector(2:end);
        else
            vector1 = Vector(end);% we at the last recursie
        end
    elseif(i<Total) % Checking if we at the end of if
        vector1 = [Vector(1:i-1) Vector(i+1:end)];
    else
        vector1 = Vector(1:i-1);
    end
    
    for j = 1:Total-1
        if(~RepetCondtion(vector1(j),Counters(2,:))) %To prevent returning on the same latter
            continue;
        end
        % Breket  counter if
        if(vector1(j) == 'D')
            Breket_temp = Breket_temp + 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp - 1;
        else
            Breket_temp = bracket_counter ;
        end
        
        if(Condtion(Vector(i),[V Vector(i)],vector1(j),Breket_temp,Total) == 0)
            if(vector1(j) == 'D')% Breket  counter updtae if becuse we have the continue function
                Breket_temp = Breket_temp - 1;
            elseif(vector1(j) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            continue ;
        end
        if(j==1) %Checking if we at the start of the for
            if(Total>1) % Checking if we at the last recursie
                vector2 = vector1(2:end);
            else
                vector2 = vector1(end);% we at the last recursie
            end
        elseif(j<Total) % Checking if we at the end of if
            vector2 = [vector1(1:j-1) vector1(j+1:end)];
        else
            vector2 = vector1(1:j-1);
        end
        
        for k = 1:Total-2
            if(~RepetCondtion(vector2(k),Counters(3,:))) %To prevent returning on the same latter
                continue;
            end
            % Breket  counter if
            if(vector2(k) == 'D')
                Breket_temp = Breket_temp + 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp - 1;
            else
                Breket_temp = bracket_counter ;
            end
            
            if(Condtion(vector1(j),[V Vector(i) vector2(k)],vector2(k),Breket_temp,Total) == 0)
                if(vector2(k) == 'D')% Breket  counter updtae if becuse we have the continue function
                    Breket_temp = Breket_temp - 1;
                elseif(vector2(k) == 'E')
                    Breket_temp = Breket_temp + 1;
                end
                continue ;
            end
            if(k==1) %Checking if we at the start of the for
                if(Total>1) % Checking if we at the last recursie
                    vector3 = vector2(2:end);
                else
                    vector3 = vector2(end);% we at the last recursie
                end
            elseif(k<Total) % Checking if we at the end of if
                vector3 = [vector2(1:k-1) vector2(k+1:end)];
            else
                vector3 = vector2(1:k-1);
            end
            
            for m = 1: Total - 3
                if(~RepetCondtion(vector3(m),Counters(4,:))) %To prevent returning on the same latter
                    continue;
                end
                % Breket  counter if
                if(vector3(m) == 'D')
                    Breket_temp = Breket_temp + 1;
                elseif(vector3(m) == 'E')
                    Breket_temp = Breket_temp - 1;
                else
                    Breket_temp = bracket_counter ;
                end
                
                if(Condtion(vector2(k),[V Vector(i) vector2(k) vector3(m)],vector3(m),Breket_temp,Total) == 0)
                    if(vector3(m) == 'D')% Breket  counter updtae if becuse we have the continue function
                        Breket_temp = Breket_temp - 1;
                    elseif(vector3(m) == 'E')
                        Breket_temp = Breket_temp + 1;
                    end
                    continue ;
                end
                if(m==1) %Checking if we at the start of the for
                    if(Total>1) % Checking if we at the last recursie
                        vector4 = vector3(2:end);
                    else
                        vector4 = vector3(end);% we at the last recursie
                    end
                elseif(m<Total) % Checking if we at the end of if
                    vector4 = [vector3(1:k-1) vector3(k+1:end)];
                else
                    vector4 = vector3(1:k-1);
                end
                
                
                for n = 1:Total-4
                    if(~RepetCondtion(vector4(n),Counters(5,:))) %To prevent returning on the same latter
                        continue;
                    end
                    % Breket  counter if
                    if(vector4(n) == 'D')
                        Breket_temp = Breket_temp + 1;
                    elseif(vector4(n) == 'E')
                        Breket_temp = Breket_temp - 1;
                    else
                        Breket_temp = bracket_counter ;
                    end
                    
                    if(Condtion(vector3(m),[V Vector(i) vector2(k) vector3(m) vector4(n)],vector4(n),Breket_temp,Total) == 0)
                        if(vector4(n) == 'D')% Breket  counter updtae if becuse we have the continue function
                            Breket_temp = Breket_temp - 1;
                        elseif(vector4(n) == 'E')
                            Breket_temp = Breket_temp + 1;
                        end
                        continue ;
                    end
                    if(n==1) %Checking if we at the start of the for
                        if(Total>1) % Checking if we at the last recursie
                            vector5 = vector4(2:end);
                        else
                            vector5 = vector4(end);% we at the last recursie
                        end
                    elseif(n<Total) % Checking if we at the end of if
                        vector5 = [vector4(1:n-1) vector4(n+1:end)];
                    else
                        vector5 = vector4(1:n-1);
                    end
                    
                    for o = 1:Total-5
                        if(~RepetCondtion(vector5(o),Counters(6,:))) %To prevent returning on the same latter
                            continue;
                        end
                        % Breket  counter if
                        if(vector5(o) == 'D')
                            Breket_temp = Breket_temp + 1;
                        elseif(vector5(o) == 'E')
                            Breket_temp = Breket_temp - 1;
                        else
                            Breket_temp = bracket_counter ;
                        end
                        
                        if(Condtion(vector4(n),[V Vector(i) vector2(k) vector3(m) vector4(n) vector5(o)],vector5(o),Breket_temp,Total) == 0)
                            if(vector5(o) == 'D')% Breket  counter updtae if becuse we have the continue function
                                Breket_temp = Breket_temp - 1;
                            elseif(vector5(o) == 'E')
                                Breket_temp = Breket_temp + 1;
                            end
                            continue ;
                        end
                        if(Sets(1) == 3)
                            if(o==1) %Checking if we at the start of the for
                                if(Total>1) % Checking if we at the last recursie
                                    vector6 = FunctionCreate3(vector5(2:end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n) vector5(o)],Size,Test,bracket_counter,Sets(2:end));
                                else
                                    vector6 = FunctionCreate3(vector5(end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                                end
                            elseif(o<Total) % Checking if we at the end of if
                                vector6 = FunctionCreate3([vector5(1:o-1) vector5(o+1:end)],Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            else
                                vector6 = FunctionCreate3(vector5(1:o-1),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            end
                        elseif(Sets(1) == 4)
                            if(o==1) %Checking if we at the start of the for
                                if(Total>1) % Checking if we at the last recursie
                                    vector6 = FunctionCreate4(vector5(2:end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n) vector5(o)],Size,Test,bracket_counter,Sets(2:end));
                                else
                                    vector6 = FunctionCreate4(vector5(end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                                end
                            elseif(o<Total) % Checking if we at the end of if
                                vector6 = FunctionCreate4([vector5(1:o-1) vector5(o+1:end)],Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            else
                                vector6 = FunctionCreate4(vector5(1:o-1),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            end
                        elseif(Sets(1) == 5)
                            if(o==1) %Checking if we at the start of the for
                                if(Total>1) % Checking if we at the last recursie
                                    vector6 = FunctionCreate5(vector5(2:end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n) vector5(o)],Size,Test,bracket_counter,Sets(2:end));
                                else
                                    vector6 = FunctionCreate5(vector5(end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                                end
                            elseif(o<Total) % Checking if we at the end of if
                                vector6 = FunctionCreate5([vector5(1:o-1) vector5(o+1:end)],Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            else
                                vector6 = FunctionCreate5(vector5(1:o-1),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            end
                        else
                            if(o==1) %Checking if we at the start of the for
                                if(Total>1) % Checking if we at the last recursie
                                    vector6 = FunctionCreate6(vector5(2:end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n) vector5(o)],Size,Test,bracket_counter,Sets(2:end));
                                else
                                    vector6 = FunctionCreate6(vector5(end),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));% we at the last recursie
                                end
                            elseif(o<Total) % Checking if we at the end of if
                                vector6 = FunctionCreate6([vector5(1:o-1) vector5(o+1:end)],Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            else
                                vector6 = FunctionCreate6(vector5(1:o-1),Total-6,[V Vector(i) vector1(j) vector2(k) vector3(m) vector4(n)],Size,Test,bracket_counter,Sets(2:end));
                            end
                        end
                        
                        if(flag==0)
                            vector_end = vector6;
                            flag = 1;
                        else
                            vector_end = [vector_end ; vector6];
                        end
                        
                        if(vector5(o) == 'D')% Breket  counter if restore
                            Breket_temp = Breket_temp - 1;
                        elseif(vector5(o) == 'E')
                            Breket_temp = Breket_temp + 1;
                        end
                        
                        if(vector5(o) == 'A')
                            Counters(6,1)= 1;
                        elseif (vector5(o) == 'B')
                            Counters(6,2)= 1;
                        elseif (vector5(o) == 'C')
                            Counters(6,3)= 1;
                        elseif (vector5(o) == 'D')
                            Counters(6,4)= 1;
                        elseif (vector5(o) == 'E')
                            Counters(6,5)= 1;
                        elseif (vector5(o) == 'W')
                            Counters(6,6)= 1;
                        elseif (vector5(o) == 'X')
                            Counters(6,7)= 1;
                        elseif (vector5(o) == 'Y')
                            Counters(6,8)= 1;
                        elseif (vector5(o) == 'Z')
                            Counters(6,9)= 1;
                        end
                    end
                    
                    if(vector4(n) == 'D')% Breket  counter if restore
                        Breket_temp = Breket_temp - 1;
                    elseif(vector4(n) == 'E')
                        Breket_temp = Breket_temp + 1;
                    end
                    
                    if(vector4(n) == 'A')
                        Counters(5,1)= 1;
                    elseif (vector4(n) == 'B')
                        Counters(5,2)= 1;
                    elseif (vector4(n) == 'C')
                        Counters(5,3)= 1;
                    elseif (vector4(n) == 'D')
                        Counters(5,4)= 1;
                    elseif (vector4(n) == 'E')
                        Counters(5,5)= 1;
                    elseif (vector4(n) == 'W')
                        Counters(5,6)= 1;
                    elseif (vector4(n) == 'X')
                        Counters(5,7)= 1;
                    elseif (vector4(n) == 'Y')
                        Counters(5,8)= 1;
                    elseif (vector4(n) == 'Z')
                        Counters(5,9)= 1;
                    end
                end
                
                if(vector3(m) == 'D')% Breket  counter if restore
                    Breket_temp = Breket_temp - 1;
                elseif(vector3(m) == 'E')
                    Breket_temp = Breket_temp + 1;
                end
                
                if(vector3(m) == 'A')
                    Counters(4,1)= 1;
                elseif (vector3(m) == 'B')
                    Counters(4,2)= 1;
                elseif (vector3(m) == 'C')
                    Counters(4,3)= 1;
                elseif (vector3(m) == 'D')
                    Counters(4,4)= 1;
                elseif (vector3(m) == 'E')
                    Counters(4,5)= 1;
                elseif (vector3(m) == 'W')
                    Counters(4,6)= 1;
                elseif (vector3(m) == 'X')
                    Counters(4,7)= 1;
                elseif (vector3(m) == 'Y')
                    Counters(4,8)= 1;
                elseif (vector3(m) == 'Z')
                    Counters(4,9)= 1;
                end
            end
            
            if(vector2(k) == 'D')% Breket  counter if restore
                Breket_temp = Breket_temp - 1;
            elseif(vector2(k) == 'E')
                Breket_temp = Breket_temp + 1;
            end
            
            if(vector2(k) == 'A')
                Counters(3,1)= 1;
            elseif (vector2(k) == 'B')
                Counters(3,2)= 1;
            elseif (vector2(k) == 'C')
                Counters(3,3)= 1;
            elseif (vector2(k) == 'D')
                Counters(3,4)= 1;
            elseif (vector2(k) == 'E')
                Counters(3,5)= 1;
            elseif (vector2(k) == 'W')
                Counters(3,6)= 1;
            elseif (vector2(k) == 'X')
                Counters(3,7)= 1;
            elseif (vector2(k) == 'Y')
                Counters(3,8)= 1;
            elseif (vector2(k) == 'Z')
                Counters(3,9)= 1;
            end
        end
        
        if(vector1(j) == 'D')% Breket  counter if restore
            Breket_temp = Breket_temp - 1;
        elseif(vector1(j) == 'E')
            Breket_temp = Breket_temp + 1;
        end
        
        if(vector1(j) == 'A')
            Counters(2,1)= 1;
        elseif (vector1(j) == 'B')
            Counters(2,2)= 1;
        elseif (vector1(j) == 'C')
            Counters(2,3)= 1;
        elseif (vector1(j) == 'D')
            Counters(2,4)= 1;
        elseif (vector1(j) == 'E')
            Counters(2,5)= 1;
        elseif (vector1(j) == 'W')
            Counters(2,6)= 1;
        elseif (vector1(j) == 'X')
            Counters(2,7)= 1;
        elseif (vector1(j) == 'Y')
            Counters(2,8)= 1;
        elseif (vector1(j) == 'Z')
            Counters(2,9)= 1;
        end
    end
    
    
    
    if(Vector(i) == 'D')% Breket  counter if restore
        Breket_temp = Breket_temp - 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp + 1;
    end
    if(Vector(i) == 'A')
        Counters(1,1)= 1;
    elseif (Vector(i) == 'B')
        Counters(1,2)= 1;
    elseif (Vector(i) == 'C')
        Counters(1,3)= 1;
    elseif (Vector(i) == 'D')
        Counters(1,4)= 1;
    elseif (Vector(i) == 'E')
        Counters(1,5)= 1;
    elseif (Vector(i) == 'W')
        Counters(1,6)= 1;
    elseif (Vector(i) == 'X')
        Counters(1,7)= 1;
    elseif (Vector(i) == 'Y')
        Counters(1,8)= 1;
    elseif (Vector(i) == 'Z')
        Counters(1,9)= 1;
    end

end

    if(flag==0) % If we didn't got any vector we need to send somthing
        VectorCreate = zeros(1,Size);
    else
        VectorCreate = vector_end ;
    end
end

function check = Condtion(V,Full_V,V_check,Breakts_counter,Total)
sz = size(Full_V);
if(sz(2) >= 2)
    if(V_check == 'E' && Full_V(end-1) == 'D') %We don't want to put the brekets on one virable , exemple what we don't want "(x)"
        check = 0;
        return;
    end
end
if(sz(2) >= 3)
    if(V_check == 'E' && Full_V(end-2) == 'D' && Full_V(end) == 'C') %We don't want to put the brekets on one virable , exemple what we don't want "(x)"
        check = 0;
        return;
    end
end
if(Total == 1 && (V_check == 'A' || V_check == 'B' || V_check == 'D' ) )% Array can't end with '+','*','('
    check = 0;
    return ;
elseif(Breakts_counter < 0) % Breaket counter can't be nagtive
    check = 0;
    return;
elseif((V == 'A')&& (V_check == 'A' || V_check == 'B' || V_check == 'C' || V_check == 'E' )) % What can't be after '+'
    check = 0;
    return ;
elseif((V == 'B')&& (V_check == 'A' || V_check == 'B' || V_check == 'C' || V_check == 'E' )) % What can't be after '*'
    check = 0;
    return ;
elseif(V == 'C' && (V_check == 'C' || V_check == 'D' || V_check == 'X' || V_check == 'Y'  || V_check == 'Z' || V_check == 'W' )) % What can't be after '^-1'
    check = 0;
    return ;
elseif((V == 'D')&& (V_check == 'A' || V_check == 'B' || V_check == 'C' || V_check == 'E' )) % What can't be after '('
    check = 0;
    return ;
elseif(V == 'E' && (V_check == 'D' || V_check == 'X' || V_check == 'Y'  || V_check == 'Z' || V_check == 'W' )) % What can't be after ')'
    check = 0;
    return ;
elseif((V == 'X' || V == 'Y' || V == 'Z' || V == 'W' )&& (V_check == 'D' || V_check == 'X' || V_check == 'Y'  || V_check == 'Z' || V_check == 'W' )) % What can't be after the chosen virabels
    check = 0;
    return ;
end
check = 1;
end

