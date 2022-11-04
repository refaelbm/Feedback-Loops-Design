function VectorCreate = FunctionCreate(Vector,Total,V,Size,Test,bracket_counter)
if(Total == 0)
    VectorCreate = V;
    %       if(V == Test)
    %           s=1;
    %       end
    return ;
end
flag = 0;
Breket_temp = bracket_counter ;
Counters = zeros(1,9);
for i = 1:Total
    if(Counters(1) == 1)
        s= 1;
    end
    if(~RepetCondtion(Vector(i),Counters)) %To prevent returning on the same latter
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
            vector = FunctionCreate(Vector(2:end),Total-1,[V Vector(i)],Size,Test,Breket_temp);
        else
            vector = FunctionCreate(Vector(end),Total-1,[V Vector(i)],Size,Test,Breket_temp);% we at the last recursie
        end
    elseif(i<Total) % Checking if we at the end of if
        vector = FunctionCreate([Vector(1:i-1) Vector(i+1:end)],Total-1,[V Vector(i)],Size,Test,Breket_temp);
    else
        vector = FunctionCreate(Vector(1:i-1),Total-1,[V Vector(i)],Size,Test,Breket_temp);
    end
    if(flag==0)
        vector_end = vector;
        flag = 1;
    else
        vector_end = [vector_end ; vector];
    end
    if(Vector(i) == 'D')% Breket  counter if restore
        Breket_temp = Breket_temp - 1;
    elseif(Vector(i) == 'E')
        Breket_temp = Breket_temp + 1;
    end
    if(Vector(i) == 'A')
        Counters(1)= 1;
    elseif (Vector(i) == 'B')
        Counters(2)= 1;
    elseif (Vector(i) == 'C')
        Counters(3)= 1;
    elseif (Vector(i) == 'D')
        Counters(4)= 1;
    elseif (Vector(i) == 'E')
        Counters(5)= 1;
    elseif (Vector(i) == 'W')
        Counters(6)= 1;
    elseif (Vector(i) == 'X')
        Counters(7)= 1;
    elseif (Vector(i) == 'Y')
        Counters(8)= 1;
    elseif (Vector(i) == 'Z')
        Counters(9)= 1;
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