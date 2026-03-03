within hvac_storage_building.Examples.BaseClasses;
block ZoneBlock2

  parameter Real ZoneAirVolume=1000 "m3";
  parameter Real HeatingAmbientTemperature=273.15+26 "K";
  parameter Real CoolingAmbientTemperature=273.15+18 "K";
  parameter Real HeatingScaleDownTemperature=273.15+22 "K";
  parameter Real CoolingScaleDownTemperature=273.15+22 "K";
  parameter Real ScaleDownHysteresis=0.1 "K";

    parameter Modelica.Units.SI.MassFlowRate mHxWater_flow_nominal=0.15 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mHxAir_flow_nominal=0.15 "Nominal mass flow rate on the air side";
    parameter Modelica.Units.SI.PressureDifference dpHxWater_nominal=50;
    parameter Modelica.Units.SI.PressureDifference dpHxAir_nominal=50;
    parameter Modelica.Units.SI.Pressure dpValve_nominal=50;

    parameter Modelica.Units.SI.ThermalConductance UA_nominal(min=0)=400
    "Thermal conductance at nominal flow, used to compute heat capacity";

  replaceable package MediumAir=Buildings.Media.Air
    "Medium model";
   replaceable package MediumWater = Buildings.Media.Water;
  Buildings.Controls.OBC.CDL.Interfaces.RealInput zonLoaReq annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,72})));
  ZoneThermalMode zoneThermalMode
    annotation (Placement(transformation(extent={{-56,62},{-36,82}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput ySysHeaCooMod annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,26})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput zonLoaAct annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={380,76})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{-114,-186},{-94,-166}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{354,-170},{374,-150}})));
  Buildings.Controls.Continuous.LimPID conPIDHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    yMin=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.001,
    reverseActing=true,
    reset=Buildings.Types.Reset.Parameter)
    annotation (Placement(transformation(extent={{-14,-102},{6,-82}})));
  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mHxWater_flow_nominal,
    m2_flow_nominal=mHxAir_flow_nominal,
    dp1_nominal=dpHxWater_nominal,
    dp2_nominal=dpHxAir_nominal,
    UA_nominal=UA_nominal)
                    annotation (Placement(transformation(
        origin={222.865,-85.0202},
        extent={{13.2434,-19.4055},{-13.2434,19.4055}},
        rotation=180)));
  Buildings.Fluid.Movers.FlowControlled_m_flow movAir(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mHxAir_flow_nominal) annotation (Placement(transformation(
        origin={181,-73},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Buildings.Fluid.Movers.FlowControlled_m_flow movWater(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mHxWater_flow_nominal,
    addPowerToMedium=false) annotation (Placement(transformation(
        origin={268,-152},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=
        mHxWater_flow_nominal) annotation (Placement(transformation(origin={281,-90},
                   extent={{-10,-10},{10,10}})));
  SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergyReq
    annotation (Placement(transformation(extent={{-86,-30},{-66,-10}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=
        mHxAir_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={194,-242})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium = MediumAir,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={378,-58})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemAirIn(redeclare package
      Medium = MediumAir, m_flow_nominal=mHxAir_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={298,-46})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemAirOut(redeclare package
      Medium = MediumAir, m_flow_nominal=mHxAir_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={142,-74})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemWaterIn(redeclare package
      Medium = MediumWater, m_flow_nominal=mHxWater_flow_nominal)
    annotation (Placement(transformation(extent={{164,-136},{184,-116}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemWaterOut(redeclare package
      Medium = MediumWater, m_flow_nominal=mHxWater_flow_nominal)
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={252,-126})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1
    annotation (Placement(transformation(extent={{102,24},{122,44}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(
    uLow=-0.5,
    uHigh=0.5,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{140,60},{160,80}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(
    uLow=-0.5,
    uHigh=0.5,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{142,24},{162,44}})));
  Buildings.Controls.OBC.CDL.Logical.Xor xor
    annotation (Placement(transformation(extent={{196,44},{216,64}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{230,44},{250,64}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{272,150},{292,170}})));
  Buildings.Controls.OBC.CDL.Logical.And and1
    annotation (Placement(transformation(extent={{334,14},{354,34}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{270,28},{290,48}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yZonHeaCooMod annotation
    (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={380,-26})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=cooCoi.Q2_flow)
    annotation (Placement(transformation(extent={{-128,-62},{-108,-42}})));
  Buildings.Fluid.Sources.Boundary_pT bou2(redeclare package Medium = MediumAir,
      nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={102,-74})));
  SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergyAct
    annotation (Placement(transformation(extent={{-86,-88},{-66,-68}})));
  Buildings.Controls.Continuous.LimPID conPIDCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    yMin=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.001,
    reverseActing=true,
    reset=Buildings.Types.Reset.Parameter)
    annotation (Placement(transformation(extent={{-24,-164},{-4,-144}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiHea
    annotation (Placement(transformation(extent={{38,-98},{58,-78}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiCoo
    annotation (Placement(transformation(extent={{34,-166},{54,-146}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=0)             annotation(
    Placement(transformation(origin={18,-128},   extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Logical.Not notValidCooling
    annotation (Placement(transformation(extent={{488,22},{508,42}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue=
        HeatingAmbientTemperature, realFalse=CoolingAmbientTemperature)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={416,-90})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={118,-244})));
equation
  connect(zonLoaReq, zoneThermalMode.ZonLoaReq)
    annotation (Line(points={{-120,72},{-58,72}}, color={0,0,127}));
  connect(movWater.port_b, port_b) annotation (Line(points={{278,-152},{348,
          -152},{348,-160},{364,-160}}, color={0,127,255}));
  connect(con2.y, movWater.m_flow_in) annotation (Line(points={{293,-90},{302,-90},
          {302,-130},{268,-130},{268,-140}}, color={0,0,127}));
  connect(zonLoaReq, separateHeatingCoolingThermalEnergyReq.EffectiveThermalEnergy)
    annotation (Line(points={{-120,72},{-120,-20},{-88,-20}}, color={0,0,127}));
  connect(senTemAirIn.port_b,cooCoi. port_a2) annotation (Line(points={{288,-46},
          {242,-46},{242,-73.3769},{236.108,-73.3769}},color={0,127,255}));
  connect(cooCoi.port_b1, senTemWaterOut.port_a) annotation (Line(points={{236.108,
          -96.6635},{252,-96.6635},{252,-116}}, color={0,127,255}));
  connect(senTemWaterOut.port_b, movWater.port_a) annotation (Line(points={{252,
          -136},{252,-152},{258,-152}}, color={0,127,255}));
  connect(cooCoi.port_a1, senTemWaterIn.port_b) annotation (Line(points={{209.622,
          -96.6635},{190,-96.6635},{190,-126},{184,-126}}, color={0,127,255}));
  connect(senTemWaterIn.port_a, port_a) annotation (Line(points={{164,-126},{122,
          -126},{122,-192},{-104,-192},{-104,-176}}, color={0,127,255}));
  connect(zoneThermalMode.yZonHeaCooMod, intToRea.u) annotation (Line(points={{-34,72},
          {20,72},{20,56},{90,56},{90,70},{98,70}},         color={255,127,0}));
  connect(ySysHeaCooMod, intToRea1.u) annotation (Line(points={{-120,26},{90,26},
          {90,34},{100,34}}, color={255,127,0}));
  connect(intToRea.y, hys.u)
    annotation (Line(points={{122,70},{138,70}}, color={0,0,127}));
  connect(intToRea1.y, hys1.u)
    annotation (Line(points={{124,34},{140,34}}, color={0,0,127}));
  connect(hys.y, xor.u1) annotation (Line(points={{162,70},{186,70},{186,54},{
          194,54}}, color={255,0,255}));
  connect(hys1.y, xor.u2) annotation (Line(points={{164,34},{186,34},{186,46},{
          194,46}}, color={255,0,255}));
  connect(xor.y, not1.u)
    annotation (Line(points={{218,54},{228,54}}, color={255,0,255}));
  connect(hys.y, and2.u1) annotation (Line(points={{162,70},{250,70},{250,160},
          {270,160}}, color={255,0,255}));
  connect(not1.y, and2.u2)
    annotation (Line(points={{252,54},{270,54},{270,152}}, color={255,0,255}));
  connect(movAir.m_flow_in, gai1.y) annotation (Line(points={{181,-85},{181,
          -108},{194,-108},{194,-230}}, color={0,0,127}));
  connect(hys.y, not2.u) annotation (Line(points={{162,70},{262,70},{262,46},{
          260,46},{260,38},{268,38}}, color={255,0,255}));
  connect(not1.y, and1.u2) annotation (Line(points={{252,54},{250,54},{250,12},
          {332,12},{332,16}}, color={255,0,255}));
  connect(not2.y, and1.u1) annotation (Line(points={{292,38},{324,38},{324,24},
          {332,24}}, color={255,0,255}));
  connect(zoneThermalMode.yZonHeaCooMod, yZonHeaCooMod) annotation (Line(points
        ={{-34,72},{20,72},{20,56},{94,56},{94,50},{184,50},{184,-4},{354,-4},{
          354,-26},{380,-26}}, color={255,127,0}));
  connect(realExpression.y, zonLoaAct) annotation (Line(points={{-107,-52},{58,
          -52},{58,0},{408,0},{408,76},{380,76}},
                                  color={0,0,127}));
  connect(bou1.ports[1], senTemAirIn.port_a) annotation (Line(points={{368,-58},
          {314,-58},{314,-46},{308,-46}}, color={0,127,255}));
  connect(cooCoi.port_b2, movAir.port_a) annotation (Line(points={{209.622,
          -73.3769},{208,-73},{191,-73}}, color={0,127,255}));
  connect(movAir.port_b, senTemAirOut.port_a) annotation (Line(points={{171,-73},
          {172,-74},{152,-74}}, color={0,127,255}));
  connect(senTemAirOut.port_b, bou2.ports[1])
    annotation (Line(points={{132,-74},{112,-74}}, color={0,127,255}));
  connect(realExpression.y, separateHeatingCoolingThermalEnergyAct.EffectiveThermalEnergy)
    annotation (Line(points={{-107,-52},{-90,-52},{-90,-78},{-88,-78}}, color={
          0,0,127}));
  connect(separateHeatingCoolingThermalEnergyReq.HeatingThermalEnergy,
    conPIDHea.u_s) annotation (Line(points={{-64,-16.4},{-54,-16.4},{-54,-92},{
          -16,-92}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergyAct.HeatingThermalEnergy,
    conPIDHea.u_m) annotation (Line(points={{-64,-74.4},{-56,-74.4},{-56,-114},
          {-4,-114},{-4,-104}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergyReq.CoolingThermalEnergy,
    conPIDCoo.u_s) annotation (Line(points={{-64,-25.8},{-52,-25.8},{-52,-154},
          {-26,-154}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergyAct.CoolingThermalEnergy,
    conPIDCoo.u_m) annotation (Line(points={{-64,-83.8},{-50,-83.8},{-50,-176},
          {-14,-176},{-14,-166}}, color={0,0,127}));
  connect(and2.y, swiHea.u2) annotation (Line(points={{294,160},{336,160},{336,
          154},{36,154},{36,-88}}, color={255,0,255}));
  connect(con3.y, swiHea.u3) annotation (Line(points={{30,-128},{38,-128},{38,
          -104},{36,-104},{36,-96}}, color={0,0,127}));
  connect(con3.y, swiCoo.u3) annotation (Line(points={{30,-128},{38,-128},{38,
          -112},{2,-112},{2,-164},{32,-164}}, color={0,0,127}));
  connect(conPIDHea.y, swiHea.u1) annotation (Line(points={{7,-92},{26,-92},{26,
          -80},{36,-80}}, color={0,0,127}));
  connect(conPIDCoo.y, swiCoo.u1) annotation (Line(points={{-3,-154},{22,-154},
          {22,-148},{32,-148}}, color={0,0,127}));
  connect(and1.y, swiCoo.u2) annotation (Line(points={{356,24},{394,24},{394,28},
          {446,28},{446,-218},{26,-218},{26,-156},{32,-156}}, color={255,0,255}));
  connect(and1.y, notValidCooling.u) annotation (Line(points={{356,24},{396,24},
          {396,28},{480,28},{480,32},{486,32}}, color={255,0,255}));
  connect(notValidCooling.y, booToRea.u) annotation (Line(points={{510,32},{498,
          32},{498,-94},{428,-94},{428,-90}}, color={255,0,255}));
  connect(swiHea.y, swi.u1) annotation (Line(points={{60,-88},{68,-88},{68,-236},
          {106,-236}}, color={0,0,127}));
  connect(swiCoo.y, swi.u3) annotation (Line(points={{56,-156},{72,-156},{72,
          -252},{106,-252}}, color={0,0,127}));
  connect(notValidCooling.y, swi.u2) annotation (Line(points={{510,32},{522,32},
          {522,-286},{78,-286},{78,-244},{106,-244}}, color={255,0,255}));
  connect(swi.y, gai1.u) annotation (Line(points={{130,-244},{172,-244},{172,
          -268},{194,-268},{194,-254}}, color={0,0,127}));
  connect(booToRea.y, bou1.T_in) annotation (Line(points={{404,-90},{404,-92},{
          392,-92},{392,-76},{400,-76},{400,-62},{390,-62}}, color={0,0,127}));
  connect(swiHea.u2, conPIDHea.trigger) annotation (Line(points={{36,-88},{16,
          -88},{16,-76},{-24,-76},{-24,-112},{-12,-112},{-12,-104}}, color={255,
          0,255}));
  connect(swiCoo.u2, conPIDCoo.trigger) annotation (Line(points={{32,-156},{28,
          -156},{28,-184},{-22,-184},{-22,-166}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -180},{360,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},{360,
            100}})));
end ZoneBlock2;
