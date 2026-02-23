within hvac_storage_building.Examples;
model hvac_water_storage_example
  extends Modelica.Icons.Example;


  parameter Integer numZon=9 "number of zones";
  parameter Integer nSeg=20 "number of tank segments";
  parameter Real heatLossRate=5 "heat loss rate in W/K";
  HeatPumps.simple_heat_pump_2d simple_heat_pump_2d(redeclare package Medium_con = MediumWater, mCon_flow_nominal = mSystemWater_flow_nominal)  annotation(
    Placement(transformation(origin = {-136, 26}, extent = {{-20, -20}, {20, 20}})));
  HeatPumps.BaseClasses.HeaPumPer heaPumPer annotation(
    Placement(transformation(origin = {-188, 30}, extent = {{-10, -10}, {10, 10}})));


  package MediumAir=Buildings.Media.Air
    "Medium model";

  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+20, X_a=
            0.4);
   parameter Modelica.Units.SI.MassFlowRate mSystemWater_flow_nominal=0.8 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mHxWater_flow_nominal=0.15 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mHxAir_flow_nominal=0.4 "Nominal mass flow rate on the air side";

    parameter Modelica.Units.SI.PressureDifference dpSystemValve_nominal=100;

    parameter Modelica.Units.SI.PressureDifference dpHxWater_nominal=100;

    parameter Modelica.Units.SI.PressureDifference dpHxAir_nominal=100;

  parameter Modelica.Units.SI.Volume VRoo=453.1 "Room volume";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=VRoo*1.2*0.3/3600
    "Nominal mass flow rate";
  Buildings.Fluid.Storage.StratifiedEnhanced tanHot(
    m_flow_nominal=mSystemWater_flow_nominal,
    VTan=0.1136,
    hTan=0.6548,
    dIns=0.0450,
    nSeg=nSeg,
    redeclare package Medium = MediumWater,
    T_start=313.15) annotation (Placement(transformation(origin={-20,8}, extent
          ={{-10,-10},{10,10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {-86, 76}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov1(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {26, 80}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, 1})  annotation(
    Placement(transformation(origin = {-28, 94}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun1(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, -1})  annotation(
    Placement(transformation(origin = {-21, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi[numZon](
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mHxWater_flow_nominal,
    m2_flow_nominal=mHxAir_flow_nominal,
    dp1_nominal=dpHxWater_nominal,
    dp2_nominal=dpHxAir_nominal,
    UA_nominal=400) annotation (Placement(transformation(
        origin={92.8647,26.9798},
        extent={{13.2434,-19.4055},{-13.2434,19.4055}},
        rotation=90)));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov11[numZon](
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mHxAir_flow_nominal) annotation (Placement(transformation(
        origin={135,65},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, dpValve_nominal = dpSystemValve_nominal) annotation(
    Placement(transformation(origin = {-4, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, dpValve_nominal = dpSystemValve_nominal) annotation(
    Placement(transformation(origin = {7, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, dpValve_nominal = dpSystemValve_nominal) annotation(
    Placement(transformation(origin = {-58, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val3(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, dpValve_nominal = dpSystemValve_nominal) annotation(
    Placement(transformation(origin = {-52, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)    annotation(
    Placement(transformation(origin={-262,-10},  extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2[numZon](k=
        mHxAir_flow_nominal) annotation (Placement(transformation(origin={141,138},
          extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.TimeTable dailyScheduleTable(table = [0, 1; 2, 0; 4, 1; 8, 3; 12, 2; 16, 4; 21, 1; 24, 1], timeScale = 3600, period = 86400)  annotation(
    Placement(transformation(origin={-244,150},    extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tanCold(
    redeclare package Medium = MediumWater,
    VTan=0.1136,
    dIns=0.0450,
    hTan=0.6548,
    m_flow_nominal=mSystemWater_flow_nominal,
    nSeg=nSeg,
    T_start=282.15) annotation (Placement(transformation(origin={-58,13},
          extent={{-10,-10},{10,10}})));
  Controls.hvac_storage_controller hvac_storage_controller
    annotation (Placement(transformation(extent={{-178,142},{-158,162}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=
        mSystemWater_flow_nominal)                                      annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-86,116})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=
        mSystemWater_flow_nominal)                                       annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={28,116})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{-238,-56},{-218,-36}})));
  Buildings.Controls.OBC.CDL.Reals.Min min1
    annotation (Placement(transformation(extent={{-238,-8},{-218,12}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{-112,-56},{-92,-36}})));
  Buildings.Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = MediumAir,
    use_T_in=true,   nPorts=9)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={108,-44})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    V=0.001,
    nPorts=20)         annotation (Placement(transformation(extent={{52,88},{72,108}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput outside_air_temperature
    annotation (Placement(transformation(extent={{-352,20},{-312,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput zone_load_actual[numZon]
    annotation (Placement(transformation(extent={{236,22},{276,64}})));
  BaseClasses.TankLoss tankLossCold(nSeg=nSeg, heatLossRate=heatLossRate)
    annotation (Placement(transformation(extent={{-144,-114},{-124,-94}})));
  BaseClasses.TankLoss tankLossHot(nSeg=nSeg, heatLossRate=heatLossRate)
    annotation (Placement(transformation(extent={{-90,-146},{-70,-126}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov2[numZon](
    redeclare package Medium = MediumWater,
    m_flow_nominal=mHxWater_flow_nominal,
    addPowerToMedium=false) annotation (Placement(transformation(
        origin={76,66},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1[numZon](k=
        mHxWater_flow_nominal) annotation (Placement(transformation(origin={93,122},
          extent={{-10,-10},{10,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput zone_load_request[numZon]
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={240,-46})));
  Buildings.Fluid.Sources.Boundary_pT bou3(redeclare package Medium = MediumAir,
      nPorts=9)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={194,124})));
equation
  connect(heaPumPer.MaxHeaPumCapHea, simple_heat_pump_2d.MaxHeaPumCapHea) annotation(
    Line(points={{-176,39.2},{-166,39.2},{-166,45.3},{-157.1,45.3}},        color = {0, 0, 127}));
  connect(heaPumPer.MaxHeaPumCapCoo, simple_heat_pump_2d.MaxHeaPumCapCoo) annotation(
    Line(points={{-176,36.6},{-164,36.6},{-164,41.7},{-157.1,41.7}},        color = {0, 0, 127}));
  connect(heaPumPer.MinHeaPumCapHea, simple_heat_pump_2d.MinHeaPumCapHea) annotation(
    Line(points={{-176,33.6},{-168,33.6},{-168,37.7},{-157.2,37.7}},        color = {0, 0, 127}));
  connect(heaPumPer.MinHeaPumCapCoo, simple_heat_pump_2d.MinHeaPumCapCoo) annotation(
    Line(points={{-176,31},{-162,31},{-162,34.3},{-157,34.3}},      color = {0, 0, 127}));
  connect(heaPumPer.COPHea, simple_heat_pump_2d.COPHea) annotation(
    Line(points={{-176,25.4},{-168,25.4},{-168,21.3},{-157.1,21.3}},        color = {0, 0, 127}));
  connect(heaPumPer.COPCoo, simple_heat_pump_2d.COPCoo) annotation(
    Line(points={{-176,21.6},{-174,21.6},{-174,17.1},{-157.1,17.1}},        color = {0, 0, 127}));
  connect(heaPumPer.TSup, simple_heat_pump_2d.TSup) annotation(
    Line(points={{-199.6,35.6},{-209.6,35.6},{-209.6,55.6},{-135.5,55.6},{
          -135.5,47.1}},                                                                            color = {0, 0, 127}));
  connect(simple_heat_pump_2d.port_b, mov.port_a) annotation(
    Line(points={{-115.2,29.4},{-96,29.4},{-96,76}},  color = {0, 127, 255}));
  connect(mov.port_b, jun.port_1) annotation(
    Line(points = {{-76, 76}, {-52, 76}, {-52, 94}, {-38, 94}}, color = {0, 127, 255}));
  connect(jun.port_2, mov1.port_a) annotation(
    Line(points = {{-18, 94}, {16, 94}, {16, 80}}, color = {0, 127, 255}));
  connect(jun1.port_2, simple_heat_pump_2d.port_a) annotation(
    Line(points={{-31,-64},{-166,-64},{-166,29.4},{-157,29.4}},      color = {0, 127, 255}));
  connect(jun.port_3, val.port_a) annotation(
    Line(points = {{-28, 84}, {-4, 84}, {-4, 56}}, color = {0, 127, 255}));
  connect(val.port_b, tanHot.port_a)
    annotation (Line(points={{-4,36},{-20,36},{-20,18}}, color={0,127,255}));
  connect(tanHot.port_b, val1.port_a)
    annotation (Line(points={{-20,-2},{7,-2},{7,-12}}, color={0,127,255}));
  connect(val1.port_b, jun1.port_3) annotation(
    Line(points={{7,-32},{-21,-32},{-21,-54}},        color = {0, 127, 255}));
  connect(jun.port_3, val2.port_a) annotation(
    Line(points = {{-28, 84}, {-58, 84}, {-58, 58}}, color = {0, 127, 255}));
  connect(jun1.port_3, val3.port_b) annotation(
    Line(points={{-21,-54},{-52,-54},{-52,-34}},        color = {0, 127, 255}));
  connect(val2.port_b, tanCold.port_b) annotation (Line(points={{-58,38},{-78,
          38},{-78,3},{-58,3}}, color={0,127,255}));
  connect(tanCold.port_a, val3.port_a) annotation (Line(points={{-58,23},{-46,
          23},{-46,-14},{-52,-14}}, color={0,127,255}));
  connect(gai.y, mov.m_flow_in)
    annotation (Line(points={{-86,104},{-86,104},{-86,88}}, color={0,0,127}));
  connect(gai1.y, mov1.m_flow_in) annotation (Line(points={{28,104},{26,104},{
          26,92},{26,92}}, color={0,0,127}));
  connect(dailyScheduleTable.y[1], hvac_storage_controller.systemCommand)
    annotation (Line(points={{-232,150},{-204,150},{-204,159.8},{-180,159.8}},
        color={255,127,0}));
  connect(hvac_storage_controller.HotTesValve, val.y) annotation (Line(points={{-156,
          162.6},{-98,162.6},{-98,140},{8,140},{8,46}},       color={0,0,127}));
  connect(val.y, val1.y) annotation (Line(points={{8,46},{20,46},{20,44},{28,44},
          {28,-22},{19,-22}}, color={0,0,127}));
  connect(val2.y, val3.y) annotation (Line(points={{-46,48},{-32,48},{-32,-24},
          {-40,-24}}, color={0,0,127}));
  connect(hvac_storage_controller.ColdTesValve, val2.y)
    annotation (Line(points={{-156,160},{-46,160},{-46,48}}, color={0,0,127}));
  connect(hvac_storage_controller.HPMode, simple_heat_pump_2d.HeaPumMod)
    annotation (Line(points={{-155.8,146.8},{-142,146.8},{-142,118},{-108,118},{
          -108,23.4},{-114.8,23.4}},  color={255,0,255}));
  connect(hvac_storage_controller.HPOnOff, simple_heat_pump_2d.HeaPumOnOff)
    annotation (Line(points={{-156,143.8},{-150,143.8},{-150,25.4},{-157.2,25.4}},
        color={255,0,255}));
  connect(hvac_storage_controller.HeatPumpSidePumpFraction, gai.u) annotation (
      Line(points={{-156,157.6},{-120,157.6},{-120,128},{-86,128}}, color={0,0,
          127}));
  connect(hvac_storage_controller.LoadSidePumpFraction, gai1.u) annotation (
      Line(points={{-156,154.4},{-88,154.4},{-88,114},{18,114},{18,128},{28,128}},
        color={0,0,127}));
  connect(con.y, min1.u2) annotation (Line(points={{-250,-10},{-244,-10},{-244,
          -4},{-240,-4}}, color={0,0,127}));
  connect(con.y, max1.u1) annotation (Line(points={{-250,-10},{-246,-10},{-246,
          -40},{-240,-40}}, color={0,0,127}));
  connect(min1.y, simple_heat_pump_2d.TSupSetHea) annotation (Line(points={{
          -216,2},{-188,2},{-188,13.1},{-157.3,13.1}}, color={0,0,127}));
  connect(max1.y, simple_heat_pump_2d.TSupSetCoo) annotation (Line(points={{
          -216,-46},{-188,-46},{-188,8.9},{-157.1,8.9}}, color={0,0,127}));
  connect(hvac_storage_controller.HeatPumpSetpoint, min1.u1) annotation (Line(
        points={{-156,151},{-144,151},{-144,122},{-240,122},{-240,8}}, color={0,
          0,127}));
  connect(hvac_storage_controller.HeatPumpSetpoint, max1.u2) annotation (Line(
        points={{-156,151},{-140,151},{-140,124},{-132,124},{-132,-52},{-240,-52}},
                 color={0,0,127}));
  connect(bou1.ports[1], jun1.port_3) annotation (Line(points={{-92,-46},{-21,-46},
          {-21,-54}}, color={0,127,255}));
  connect(mov1.port_b, vol1.ports[1]) annotation (Line(points={{36,80},{48,80},{
          48,88},{60.1,88}}, color={0,127,255}));
  connect(outside_air_temperature, heaPumPer.TOut) annotation (Line(points={{-332,
          40},{-266,40},{-266,25.4},{-200,25.4}}, color={0,0,127}));
  connect(tankLossCold.port_a, tanCold.heaPorVol) annotation (Line(points={{-123.4,
          -104},{-118,-104},{-118,-4},{-58,-4},{-58,13}}, color={191,0,0}));
  connect(tankLossHot.port_a, tanHot.heaPorVol) annotation (Line(points={{-69.4,
          -136},{-64,-136},{-64,-44},{-32,-44},{-32,-24},{-30,-24},{-30,-20},{-34,
          -20},{-34,-8},{-36,-8},{-36,8},{-20,8}}, color={191,0,0}));
  connect(outside_air_temperature, tankLossCold.outside_air_temperature)
    annotation (Line(points={{-332,40},{-288,40},{-288,-104},{-146,-104}},
        color={0,0,127}));
  connect(outside_air_temperature, tankLossHot.outside_air_temperature)
    annotation (Line(points={{-332,40},{-288,40},{-288,-104},{-154,-104},{-154,-136},
          {-92,-136}}, color={0,0,127}));
  connect(vol1.ports[2], jun1.port_1) annotation (Line(points={{60.3,88},{56,88},
          {56,-80},{-11,-80},{-11,-64}}, color={0,127,255}));
  connect(vol1.ports[3:11], mov2.port_a) annotation (Line(points={{62.1,88},{62.1,
          82},{76,82},{76,76}}, color={0,127,255}));
  connect(mov2.port_b, cooCoi.port_a1) annotation (Line(points={{76,56},{76,46},
          {81.2214,46},{81.2214,40.2232}}, color={0,127,255}));
  connect(cooCoi.port_b1, vol1.ports[12:20]) annotation (Line(points={{81.2214,13.7364},
          {81.2214,6},{63.9,6},{63.9,88}}, color={0,127,255}));
  connect(con1.y, mov2.m_flow_in) annotation (Line(points={{105,122},{114,122},{
          114,66},{88,66}}, color={0,0,127}));
  connect(con2.y, mov11.m_flow_in) annotation (Line(points={{153,138},{162,138},
          {162,82},{116,82},{116,65},{123,65}}, color={0,0,127}));
  connect(mov11.port_a, cooCoi.port_b2) annotation (Line(points={{135,55},{136,55},
          {136,46},{104.508,46},{104.508,40.2232}}, color={0,127,255}));
  connect(cooCoi.port_a2, bou2.ports[1:9]) annotation (Line(points={{104.508,
          13.7364},{104.508,-28},{106.222,-28},{106.222,-34}},
                                                      color={0,127,255}));
  connect(mov11.port_b, bou3.ports[1:9]) annotation (Line(points={{135,75},{135,
          84},{195.778,84},{195.778,114}}, color={0,127,255}));
  annotation(
    experiment(StartTime = 0, StopTime = 432000, Tolerance = 1e-06, Interval = 60),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"),
  Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end hvac_water_storage_example;
