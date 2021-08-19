function out = model
%
% trial.m
%
% Model exported on Jul 9 2021, 14:08 by COMSOL 5.6.0.280.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\xgu19\OneDrive\Documents\Wolynes Lab\COMSOl');

model.label('trial.mph');

model.param.set('q', '0.03542[C/m^2]');
model.param.set('c_r', '60', 'cylinder radius');
model.param.set('c_h', '3200', 'cylinder h');
model.param.set('s_r', '0.05', 'sphere radius');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').lengthUnit('nm');
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').set('pos', [-400 -400 -2000]);
model.component('comp1').geom('geom1').feature('blk1').set('axis', [0 0 1]);
model.component('comp1').geom('geom1').feature('blk1').set('size', [800 800 4000]);
model.component('comp1').geom('geom1').create('cyl1', 'Cylinder');
model.component('comp1').geom('geom1').feature('cyl1').set('pos', [0 0 -1600]);
model.component('comp1').geom('geom1').feature('cyl1').set('r', 'c_r');
model.component('comp1').geom('geom1').feature('cyl1').set('h', 'c_h');
model.component('comp1').geom('geom1').create('dif1', 'Difference');
model.component('comp1').geom('geom1').feature('dif1').set('selresult', true);
model.component('comp1').geom('geom1').feature('dif1').selection('input').set({'blk1'});
model.component('comp1').geom('geom1').feature('dif1').selection('input2').set({'cyl1'});
model.component('comp1').geom('geom1').create('cyl2', 'Cylinder');
model.component('comp1').geom('geom1').feature('cyl2').set('selresult', true);
model.component('comp1').geom('geom1').feature('cyl2').set('pos', [0 0 -1600]);
model.component('comp1').geom('geom1').feature('cyl2').set('r', 'c_r');
model.component('comp1').geom('geom1').feature('cyl2').set('h', 'c_h');
model.component('comp1').geom('geom1').create('sph1', 'Sphere');
model.component('comp1').geom('geom1').feature('sph1').set('selresult', true);
model.component('comp1').geom('geom1').feature('sph1').set('pos', [6.754902942615239 -7.373688780783198 1]);
model.component('comp1').geom('geom1').feature('sph1').set('r', 's_r');
model.component('comp1').geom('geom1').create('dif2', 'Difference');
model.component('comp1').geom('geom1').feature('dif2').set('selresult', true);
model.component('comp1').geom('geom1').feature('dif2').selection('input').named('cyl2');
model.component('comp1').geom('geom1').feature('dif2').selection('input2').named('sph1');
model.component('comp1').geom('geom1').run;

model.component('comp1').view('view1').hideEntities.create('hide1');
model.component('comp1').view('view1').hideEntities('hide1').geom('geom1', 2);
model.component('comp1').view('view1').hideEntities('hide1').set([1 2 3 4 5 11 20]);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.named('geom1_dif1_dom');
model.component('comp1').material('mat2').selection.named('geom1_dif2_dom');

model.component('comp1').physics.create('es', 'Electrostatics', 'geom1');
model.component('comp1').physics('es').create('gnd1', 'Ground', 2);
model.component('comp1').physics('es').feature('gnd1').selection.set([1 2 3 4 5 20]);
model.component('comp1').physics('es').create('sfcd1', 'SurfaceChargeDensity', 2);
model.component('comp1').physics('es').feature('sfcd1').selection.set([12 13 14 15 16 17 18 19]);

model.component('comp1').material('mat1').label('Outer');
model.component('comp1').material('mat1').propertyGroup('def').label('Basic');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'3e5' '0' '0' '0' '3e5' '0' '0' '0' '3e5'});
model.component('comp1').material('mat2').label('Inner');
model.component('comp1').material('mat2').propertyGroup('def').label('Basic');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'20000' '0' '0' '0' '20000' '0' '0' '0' '20000'});

model.component('comp1').physics('es').feature('sfcd1').set('rhoqs', 'q');


model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 2);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').selection.set([12 13 14 15 16 17 18 19]);
model.component('comp1').mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').selection.geom('geom1', 2);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size2').selection.set([6 7 8 9 10 11]);

model.component('comp1').mesh('mesh1').feature('size').set('hauto', 2);
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
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').runAll;
mphsave(model,'trial');
out = model;
% 
% disp(mphinterp(model,'V','coord',[0;0;0]));
