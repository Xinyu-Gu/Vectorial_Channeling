
rise = 1;
epsi = 0.05;
r_o = 60;
r_i = 10;
D_o = 3e5;
x = 50:30:800;
D_in = 1e4:1e4:30e4;
%k_in = [2e6 2e5];
k_in = [6e6 4e6 2e6 2e5];
r_cpeb = zeros(length(k_in),length(x),length(D_in));
r_rim = zeros(length(k_in),length(x),length(D_in));
N_all = 800;



model = mphopen('trial');
model.hist.disable;
model.param.set('q', '0.03542[C/m^2]');  %should times 100, corrected in rate_c.m
model.param.set('s_r', epsi);
%model.param.set('c_r', r_o+2*epsi);
model.param.set('c_r', r_o);
model.param.set('c_h', 4*N_all*rise);


model.component('comp1').geom('geom1').feature('cyl1').set('pos', [0 0 -2*N_all*rise]);
model.component('comp1').geom('geom1').feature('cyl2').set('pos', [0 0 -2*N_all*rise]);
model.component('comp1').geom('geom1').feature('blk1').set('pos', [-400 -400 (-2*N_all*rise-400)]);
model.component('comp1').geom('geom1').feature('blk1').set('size', [800 800 (800+4*N_all*rise)]);
cg_o = fibonacci_cylinder ( r_o-2*epsi, N_all, rise );
cg_i = fibonacci_cylinder ( r_i, N_all, rise );
    
    
for bb = 1:length(D_in)
    D_i = D_in(bb);      
    model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {num2str(D_i) '0' '0' '0' num2str(D_i) '0' '0' '0' num2str(D_i)});

    g_ii = zeros ( N_all, 1 );
    g_io = zeros ( N_all, 1 );
    g_oi = zeros ( N_all, 1 );
    g_oo = zeros ( N_all, 1 );        
    
    model.component('comp1').geom('geom1').feature('sph1').set('pos', [cg_o(1,1:3)]);
    model.study('std1').run;   
    for jj = 2:N_all
        g_oo(jj) = mphinterp(model,'V','coord',[transpose(cg_o(jj,1:3))]);
    end  
    
    for jj = 1:N_all
        g_oi(jj) = mphinterp(model,'V','coord',[transpose(cg_i(jj,1:3))]);
    end

    
    model.component('comp1').geom('geom1').feature('sph1').set('pos', [cg_i(1,1:3)]);
    model.study('std1').run; 
    for jj = 2:N_all
        g_ii(jj) = mphinterp(model,'V','coord',[transpose(cg_i(jj,1:3))]);
    end          
    for jj = 1:N_all
        g_io(jj) = mphinterp(model,'V','coord',[transpose(cg_o(jj,1:3))]);
    end
    
    save([num2str(bb),'_g_oo.txt'],'g_oo');
    save([num2str(bb),'_g_io.txt'],'g_io');
    save([num2str(bb),'_g_oi.txt'],'g_oi');
    save([num2str(bb),'_g_ii.txt'],'g_ii');
    
% 
%  
%     
%     for cc = 1:length(k_in)
%         k_i = k_in(cc);
%         lamb0 = 1 - k_i/4/pi/D_o/(r_o-r_i);    
%         
%         for aa = 1:length(x)
%             N = x(aa);
%             c0 = ones(N,1);
%             
%             lamb = zeros ( N, N );
%             for jj = 1:N
%                 for kk = 1:N
%                     if jj == kk
%                         lamb(kk,jj) = 1-k_i/4/pi*g_io(abs(jj-kk)+1);
%                     else
%                         lamb(kk,jj) = k_i/4/pi*(g_oo(abs(jj-kk)+1)- g_io(abs(jj-kk)+1));
%                     end
%                 end
%             end
%             rate = lamb \ c0;
%             r_cpeb(cc,aa,bb) = mean(rate)*lamb0;
%             
%             lamb = zeros ( N, N );
%             for jj = 1:N
%                 for kk = 1:N
%                     if jj == kk
%                         lamb(kk,jj) = 1-k_i/4/pi*g_oi(abs(jj-kk)+1);
%                     else
%                         lamb(kk,jj) = k_i/4/pi*(g_ii(abs(jj-kk)+1)- g_oi(abs(jj-kk)+1));
%                     end
%                 end
%             end
%             rate = lamb \ c0;
%             r_rim(cc,aa,bb) = mean(rate)*lamb0;
%             
%             disp([N,D_i,k_i]);
%         end

        
%    end
    
    
end


% save('r_cpeb_nk.mat','r_cpeb')
% save('r_rim_nk.mat','r_rim')
% disp(g_ii);
% disp(cg_i);

% scatter3(cg_o(1:N_all,1),cg_o(1:N_all,2),cg_o(1:N_all,3));
% hold on;
% scatter3(cg_i(1:N_all,1),cg_i(1:N_all,2),cg_i(1:N_all,3));
