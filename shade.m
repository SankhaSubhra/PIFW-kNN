function shade(TR, run)

global b f W k

% Dimention of each vector
D = b*f + 1;

% Population size
NP = 50; % Edit here for adjusting the population size.

% Number of generations
Gen = 200; % Edit here for adjusting the number of generations.

% The limiting values of elements of vectors
x_min = 0;
x_max = 1;

% Size of Archieve
H=20; % Edit here for adjusting the size of archieve.

% Initializing variables and vectors
G = 1;
k1 = 1;
M_Cr = 0.5*ones(1,H);
M_F = 0.5*ones(1,H);
U = zeros(1,D);
X = zeros(NP,D);
prev_func_value = zeros(NP,1);
A=[];

% Initialization of chromosome
for i = 1:NP
	X(i,:) = (x_min + (x_max-x_min).*rand(1,D));
	
	% Extracting Weight matrix and value of k from the chromosome
	parameter = extract(X(i,:));
	W = parameter.W;
	
	% Retaining the value of k
	k = ceil(parameter.k * sqrt(size(TR,1)));
	
	% Calling fitness function
	prev_func_value(i) = fitness(TR);
end

min_func_value = inf;

while G<=Gen && min_func_value>0
	
	SCR=[];
	SF=[];
	delta_f=[];
	
	for i=1:NP
		r_i=randi([1,H],1,1);
		
		cr_i = normrnd(M_Cr(r_i), 0.1);
		cr_i = max(cr_i, 0);
		cr_i = min(cr_i, 1);
		
		while true
			F = cauchy_rand(M_F(r_i), 0.1, 1);
			if 0<F && F<=1
				break;
			end
		end
		
		p = 2/NP + rand()*(0.2-2/NP);
		p = round(p*NP);
		
		[~, I] = sort(prev_func_value);
		p_best = randi([1,p],1,1);
		p_best = I(p_best);
		
		while true
			r1 = randi([1,NP],1,1);
			if r1 ~= i
				break;
			end
		end
		
		if isempty(A)
			A_union_P = X;
		else
			A_union_P = union(A, X, 'rows');
		end
		r2 = randi([1,size(A_union_P,1)], 1, 1);
		
		% Mutation
		V = X(i,:) + F*(X(p_best,:)-X(i,:)) + F*(X(r1,:)-A_union_P(r2,:));
		if V(end) <= 0
			V(end) = rand(1,1);
		end
		
		% Crossover
		j_rand = randi([1 D], 1, 1);
		l = rand(1, D);
		U(l<=cr_i) = V(l<=cr_i);
		U(j_rand) = V(j_rand);
		U(l>cr_i) = X(i, l>cr_i);
		
		% Selection
		parameter = extract(U);
		W = parameter.W;
		k = ceil(parameter.k * sqrt(size(TR,1)));
		func_val_U = fitness(TR);
		
		% Updating parameter archive
		if func_val_U < prev_func_value(i)
			SCR = [SCR, cr_i];
			SF = [SF, F];
			A = [A; X(i,:)];
			delta_f = [delta_f, abs(prev_func_value(i)-func_val_U)];
			X(i,:) = U;
			prev_func_value(i) = func_val_U;
		end
		
		if min_func_value > prev_func_value(i)
			min_func_value = prev_func_value(i);
			ans_vector = X(i,:);
		end
		
		if size(A,1) > NP
			temp = randi([1,NP],1,1);
			A(temp,:) = [];
		end
		
	end
	
	if isempty(SCR)==0 && isempty(SF)==0
		M_Cr(k1) = wt_Mean(SCR, delta_f);
		M_F(k1) = wt_Lehmer_Mean(SF, delta_f);
		k1 = k1+1;
		if k1>H
			k1 = 1;
		end
    end
		
    membership_assignment(TR);
		
    h = sprintf('Run %d Gen %d: Error= %f',run,G,min_func_value);
    disp(h);
	
	G = G+1;
	
end

% Extracting the final values of parameters
parameter = extract(ans_vector);
W = parameter.W;
k = ceil(parameter.k * sqrt(size(TR,1)));

