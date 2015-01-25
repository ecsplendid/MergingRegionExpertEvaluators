function [Losses,Paths] = BestLossPath( L )
% L is loss matrix
% for each number of switches, P(i+1) gives you the loss of the best path
% with i switches (allow zero switches, we have one based indexing)

num_experts = size(L,1);
T = size(L,2);
LossPaths = -inf( T, T-1, num_experts );
PreviousGuy = -inf( T, T-1, num_experts );
Paths = nan( T-1, T ); % switches by Times
LossPaths( 2, 0+1, 1 ) = L(1,2);

for t = 3:T    
    % must stay where we are
    % M=0
    LossPaths( t, 0+1, 1 ) = LossPaths( t-1, 0+1, 1 ) + L(1, t);
    PreviousGuy( t, 0+1, 1 ) = 1;
    
    LossPaths( t, 0+1, 2:t-1) = inf;
    
    for M=1:t-2
        
        [pool poolguy] = min(LossPaths( t-1, M-1+1, 1:t-2));
        
        for e=1:t-2
           
             LossPaths( t, M+1, e ) = min( pool,  LossPaths( t-1, M+1, e )  ) + L(e, t);
             
             if( pool <= LossPaths( t-1, M+1, e ) )
                PreviousGuy( t, M+1, e ) = poolguy;
             else
                 PreviousGuy( t, M+1, e ) = e;
             end
             
        end    
        
        % special case for the highest expert only has a switch in
        LossPaths( t, M+1, t-1 ) = pool + L(t-1, t);
        PreviousGuy( t, M+1, t-1 ) = poolguy;
    end
    
    %M too big, we can only switch in
    [pool poolguy] = min( LossPaths( t-1, t-2, 1:t-2) );
    
    for e=1:t-1
         LossPaths( t, t-2+1, e ) = pool + L(e, t);
         PreviousGuy( t, t-2+1, e ) = poolguy;
    end   
end

[Losses Indices] = min( squeeze( LossPaths( T, :, 1:T-1 ) ),[],2); 

% now create the paths


for M=0:T-2
    
    current_guy = Indices(M+1);
    current_M = M;
    
    for t=T:-1:2
        
        Paths(M+1, t) = current_guy;
        previous_guy = PreviousGuy( t, current_M + 1, current_guy );
       
        if previous_guy ~= current_guy || current_M+2==t; current_M = current_M-1; end
        current_guy = previous_guy;
    end
end


end