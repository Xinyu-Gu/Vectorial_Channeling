epsi = 0.05;
r_o = 60;
r_i = 10;
D_o = 3e5;
x = 20:10:390;
D_in = 1e4;
k_in = [2e6 2e5];
U = -4:0.2:4;
r_cpeb = zeros(length(k_in),length(x),length(U));
r_rim = zeros(length(k_in),length(x),length(U));
N_all = 2000;
t = linspace(1,-1,N_all);

r0=45;
w_theta=5;

    
    
for bb = 1:length(U) 
    k0 = U(bb); 
    
    g_ii = load([num2str(bb),'_g_ii.txt']);
    g_io = load([num2str(bb),'_g_io.txt']);
    g_oi = load([num2str(bb),'_g_oi.txt']);
    g_oo = load([num2str(bb),'_g_oo.txt']);  

    for cc = 1:length(k_in)
        k_i = k_in(cc);
        lamb0 = 1 - k_i/4/pi/D_o/(r_o-r_i-2*epsi);    
        
        for aa = 1:length(x)
            N = x(aa);
            tt = linspace(1,-1,N);
            
            lamb = 1+k_i*1e-27*(sum(interp1(t,g_oo(1:N_all,4),tt(2:N))) - sum(interp1(t,g_io(1:N_all,4),tt)));
            %lamb = 1+k_i*1e-6*(sum(interp1(t,g_oo(1:N_all),tt(2:N))) - sum(interp1(t,g_io(1:N_all),tt)));
            
            r_cpeb(cc,aa,bb) = lamb0/lamb * exp(-k0/2*(1+tanh((r0-r_o)/w_theta)));
            
            lamb = 1+k_i*1e-27*(sum(interp1(t,g_ii(1:N_all,4),tt(2:N))) - sum(interp1(t,g_oi(1:N_all,4),tt)));
            %lamb = 1+k_i*1e-6*(sum(interp1(t,g_ii(1:N_all),tt(2:N))) - sum(interp1(t,g_oi(1:N_all),tt)));
            
            r_rim(cc,aa,bb) = lamb0/lamb * exp(-k0/2*(1+tanh((r0-r_i)/w_theta)));
            
            disp([N,k0,k_i]);
        end 
    end
end


save('r_cpeb.mat','r_cpeb')
save('r_rim.mat','r_rim')
% disp(g_ii);
% disp(cg_i);

% scatter3(cg_o(1:N_all,1),cg_o(1:N_all,2),cg_o(1:N_all,3));
% hold on;
% scatter3(cg_i(1:N_all,1),cg_i(1:N_all,2),cg_i(1:N_all,3));
