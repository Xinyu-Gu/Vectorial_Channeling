
epsi = 0.05;
r_o = 60;
r_i = 10;
D_o = 3e-13;
D_in = 1e-14;
N_all = 2000;



model = mphopen('trial');
model.hist.disable;
model.param.set('r0', '0[nm]');  %delta G = 2=kBT
%model.param.set('s_r', epsi);
%model.param.set('J_s', '3.1831e17[mol/(m^2*s)]');
%model.param.set('Agg_r', r_o+2*epsi);

sg_o = fibonacci_sphere ( r_o-2*epsi, N_all );
sg_i = fibonacci_sphere ( r_i, N_all );
dlmwrite('sg_o.txt',sg_o,'delimiter','\t');
dlmwrite('sg_i.txt',sg_i,'delimiter','\t');
    
for bb = 1:length(D_in) 
    D_i = D_in(bb);      
    model.component('comp1').material('mat1').propertyGroup('def').set('diffusion', {num2str(D_i) '0' '0' '0' num2str(D_i) '0' '0' '0' num2str(D_i)});
    model.component('comp1').geom('geom1').feature('sph4').set('pos', [sg_o(1,1:3)]);
    model.study('std1').run;   
    model.result.export('data1').set('filename', [num2str(bb),'_g_oo.txt']);
    model.result.export('data1').set('coordfilename', 'sg_o.txt');
    model.result.export('data1').run;
    
    model.result.export('data1').set('filename', [num2str(bb),'_g_oi.txt']);
    model.result.export('data1').set('coordfilename', 'sg_i.txt');
    model.result.export('data1').run;
% 
%     
    model.component('comp1').geom('geom1').feature('sph4').set('pos', [sg_i(1,1:3)]);
    model.study('std1').run; 
    model.result.export('data1').set('filename', [num2str(bb),'_g_io.txt']);
    model.result.export('data1').set('coordfilename', 'sg_o.txt');
    model.result.export('data1').run;
    
    model.result.export('data1').set('filename', [num2str(bb),'_g_ii.txt']);
    model.result.export('data1').set('coordfilename', 'sg_i.txt'); 
    model.result.export('data1').run;
    disp(D_i);


end

%mphsave(model,'final_i');

