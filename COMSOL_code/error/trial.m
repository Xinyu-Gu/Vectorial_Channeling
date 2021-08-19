function out = model
%
% trial.m
%
% Model exported on Jun 1 2021, 23:58 by COMSOL 5.6.0.280.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\xgu19\OneDrive\Documents\deltaG');

model.param.set('r0', '0[nm]');
model.param.set('Agg_r', 60);
model.param.descr('Agg_r', 'aggregate radius');
model.param.set('s_r', 0.05);
model.param.descr('s_r', 'sphere radius');
model.param.set('J_s', ' 3.1831e19[mol/(m^2*s)]');
model.param.descr('J_s', 'sink flux');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').lengthUnit('nm');
model.component('comp1').geom('geom1').create('sph1', 'Sphere');
model.component('comp1').geom('geom1').feature('sph1').set('selresult', true);
model.component('comp1').geom('geom1').feature('sph1').set('r', 'Agg_r');
model.component('comp1').geom('geom1').create('sph2', 'Sphere');
model.component('comp1').geom('geom1').feature('sph2').set('selresult', true);
model.component('comp1').geom('geom1').feature('sph2').set('r', 'Agg_r');
model.component('comp1').geom('geom1').create('sph3', 'Sphere');
model.component('comp1').geom('geom1').feature('sph3').set('selresult', true);
model.component('comp1').geom('geom1').feature('sph3').set('r', 800);
model.component('comp1').geom('geom1').create('dif1', 'Difference');
model.component('comp1').geom('geom1').feature('dif1').set('selresult', true);
model.component('comp1').geom('geom1').feature('dif1').selection('input').named('sph3');
model.component('comp1').geom('geom1').feature('dif1').selection('input2').named('sph1');
model.component('comp1').geom('geom1').create('sph4', 'Sphere');
model.component('comp1').geom('geom1').feature('sph4').set('selresult', true);
model.component('comp1').geom('geom1').feature('sph4').set('pos', [10 0 0]);
model.component('comp1').geom('geom1').feature('sph4').set('r', 's_r');
model.component('comp1').geom('geom1').create('dif2', 'Difference');
model.component('comp1').geom('geom1').feature('dif2').set('selresult', true);
model.component('comp1').geom('geom1').feature('dif2').selection('input').named('sph2');
model.component('comp1').geom('geom1').feature('dif2').selection('input2').named('sph4');
model.component('comp1').geom('geom1').run;

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.named('geom1_dif2_dom');
model.component('comp1').material('mat2').selection.named('geom1_dif1_dom');
model.component('comp1').material('mat1').label('in');
model.component('comp1').material('mat1').propertyGroup('def').set('diffusion', {'1e-14' '0' '0' '0' '1e-14' '0' '0' '0' '1e-14'});
model.component('comp1').material('mat2').label('out');
model.component('comp1').material('mat2').propertyGroup('def').set('diffusion', {'3e-13' '0' '0' '0' '3e-13' '0' '0' '0' '3e-13'});

model.component('comp1').physics.create('tds', 'DilutedSpecies', 'geom1');
model.component('comp1').physics('tds').create('conc1', 'Concentration', 2);
model.component('comp1').physics('tds').feature('conc1').selection.set([1 2 3 4 9 10 13 16]);
model.component('comp1').physics('tds').create('srf1', 'SurfaceReactionsFlux', 2);
model.component('comp1').physics('tds').feature('srf1').selection.set([17 18 19 20 21 22 23 24]);
model.component('comp1').physics('tds').create('cdm2', 'ConvectionDiffusionMigration', 3);
model.component('comp1').physics('tds').feature('cdm2').selection.set([1]);
model.component('comp1').physics('tds').prop('TransportMechanism').set('Convection', false);
model.component('comp1').physics('tds').prop('TransportMechanism').set('Migration', true);
model.component('comp1').physics('tds').feature('cdm1').set('DiffusionMaterialList', 'mat1');
model.component('comp1').physics('tds').feature('cdm1').set('D_c_mat', 'def');
model.component('comp1').physics('tds').feature('cdm1').set('z', 1);
model.component('comp1').physics('tds').feature('cdm1').set('V', '(r0/sqrt(x^2+y^2+z^2)) [V]');
model.component('comp1').physics('tds').feature('cdm1').set('minput_temperature_src', 'userdef');
model.component('comp1').physics('tds').feature('cdm1').set('minput_temperature', '300 [K]');
model.component('comp1').physics('tds').feature('conc1').set('species', true);
model.component('comp1').physics('tds').feature('conc1').set('c0', 0);
model.component('comp1').physics('tds').feature('srf1').set('J0_c', 'J_s');
model.component('comp1').physics('tds').feature('cdm2').set('DiffusionMaterialList', 'mat2');
model.component('comp1').physics('tds').feature('cdm2').set('D_c_mat', 'def');
model.component('comp1').physics('tds').feature('cdm2').set('z', 0);
model.component('comp1').physics('tds').feature('cdm2').set('V', '0 [V]');
model.component('comp1').physics('tds').feature('cdm2').set('minput_temperature_src', 'userdef');
model.component('comp1').physics('tds').feature('cdm2').set('minput_temperature', '300 [K]');


model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 2);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').selection.set([17 18 19 20 21 22 23 24]);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').selection.geom('geom1', 2);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').selection.set([5 6 7 8 11 12 14 15]);


model.component('comp1').mesh('mesh1').feature('size').set('hauto', 1);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hmax', 0.005);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hmin', 0.001);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hminactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hcurve', 0.1);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hcurveactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hnarrow', 1);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hnarrowactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hgrad', 1.05);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hgradactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hmax', 5);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hmin', 1);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hminactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hcurve', 0.1);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hcurveactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hnarrow', 1);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hnarrowactive', true);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hgrad', 1.05);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').set('hgradactive', true);
model.component('comp1').mesh('mesh1').run;


model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').runAll;


model.result.export.create('data1', 'Data');
model.result.export('data1').set('expr', {'c'});
model.result.export('data1').set('unit', {'mol/m^3'});
% model.result.export('data1').set('filename', 'Untitled.txt');
model.result.export('data1').set('location', 'file');
% model.result.export('data1').set('coordfilename', 'tmp.txt'); 
% model.result.export('data1').run;

% disp(mphinterp(model,'c','coord',[0;0;0]));
 disp(mphinterp(model,'c','coord',[0;10;0]));
 disp(mphinterp(model,'c','coord',[60;0;0]));
mphsave(model,'trial');

out = model;
