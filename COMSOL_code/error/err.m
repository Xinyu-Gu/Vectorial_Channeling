N_all = 2000;
t = linspace(1,-1,N_all);

Coo=load('1_g_oo.txt');
x1=Coo(1:N_all,4);
plot(t,x1,'k','linewidth',1,'DisplayName','\lambda^B (COMSOL)');
hold on;
% 
Aoo=load('g_oo.txt');
x2=Aoo(1:N_all)*1e21;
plot(t,x2,'--k','linewidth',1,'DisplayName','\lambda^B (Analy)');
hold on;
% 
% % % 
Cio=load('1_g_io.txt');
x3=Cio(1:N_all,4);
plot(t,x3,'r','linewidth',1,'DisplayName','\lambda^E (COMSOL)');
hold on;


Aio=load('g_io.txt');
x4=Aio(1:N_all)*1e21;
plot(t,x4,'--r','linewidth',1,'DisplayName','\lambda^E (Analy)');
hold on;



% Cii=load('1_g_ii.txt');
% x5=Cii(1:N_all,4);
% plot(t,x5,'k','linewidth',1,'DisplayName','\lambda^B (COMSOL)');
% hold on;
% 
% Aii=load('g_ii.txt');
% x6=Aii(1:N_all)*1e21;
% plot(t,x6,'--k','linewidth',1,'DisplayName','\lambda^B (Analy)');
% hold on;

% Coi=load('1_g_oi.txt');
% x7=Coi(1:N_all,4);
% plot(t,x7,'r','linewidth',1,'DisplayName','\lambda^E (COMSOL)');
% hold on;
% 
% Aoi=load('g_oi.txt');
% x8=Aoi(1:N_all)*1e21;
% plot(t,x8,'--r','linewidth',1,'DisplayName','\lambda^E (Analy)');
% hold on;


%legend('Location','northeast','NumColumns',2,'Fontsize',10);
xlabel('cos\theta'); ylabel('\lambda (s/m^3)');
ax = gca;
ax.FontSize = 16;


