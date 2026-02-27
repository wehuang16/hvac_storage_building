within hvac_storage_building.Examples;
model hvac_water_storage_example_original
  extends Modelica.Icons.Example;
  HeatPumps.simple_heat_pump_2d_old simple_heat_pump_2d(redeclare package
      Medium_con = MediumWater, mCon_flow_nominal=mWater_flow_nominal)
    annotation (Placement(transformation(origin={-136,26}, extent={{-20,-20},{
            20,20}})));
  HeatPumps.BaseClasses.HeaPumPer heaPumPer annotation(
    Placement(transformation(origin = {-188, 30}, extent = {{-10, -10}, {10, 10}})));

  package MediumAir=Buildings.Media.Air
    "Medium model";

  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+20, X_a=
            0.4);
   parameter Modelica.Units.SI.MassFlowRate mWater_flow_nominal=0.8 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal=0.4 "Nominal mass flow rate on the air side";

    parameter Modelica.Units.SI.PressureDifference dpValve_nominal=100;

    parameter Modelica.Units.SI.PressureDifference dpWater_nominal=100;

    parameter Modelica.Units.SI.PressureDifference dpAir_nominal=100;

  inner Buildings.ThermalZones.EnergyPlus_9_6_0.Building building(
    idfName=Modelica.Utilities.Files.loadResource(
      "modelica://hvac_storage_building/Resources/Data/SingleFamilyHouse_TwoSpeed_ZoneAirBalance.idf"),
    epwName=Modelica.Utilities.Files.loadResource(
      "modelica://hvac_storage_building/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
    weaName=Modelica.Utilities.Files.loadResource(
      "modelica://hvac_storage_building/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
    usePrecompiledFMU=false,
    computeWetBulbTemperature=false)
    "Building model"
    annotation (Placement(transformation(origin = {174, 36}, extent = {{-80, -90}, {-60, -70}})));
  parameter Modelica.Units.SI.Volume VRoo=453.1 "Room volume";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=VRoo*1.2*0.3/3600
    "Nominal mass flow rate";
  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon(
    redeclare package Medium=MediumAir,
    zoneName="LIVING ZONE",
    nPorts=4)
    "Thermal zone"
    annotation (Placement(transformation(origin = {186, 38}, extent = {{0, -20}, {40, 20}})));
  Buildings.Fluid.FixedResistances.PressureDrop duc(
    redeclare package Medium=MediumAir,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=m_flow_nominal)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(origin = {186, 38}, extent = {{10, -50}, {-10, -30}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData bou(
    redeclare package Medium=MediumAir,
    nPorts=1,
    m_flow=m_flow_nominal)
    "Boundary condition"
    annotation (Placement(transformation(origin = {186, 38}, extent = {{-40, -90}, {-20, -70}})));
  Buildings.Fluid.Sources.Boundary_pT freshAir(
    redeclare package Medium=MediumAir,
    nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(origin = {186, 38}, extent = {{-40, -50}, {-20, -30}})));
  Modelica.Blocks.Sources.Constant qIntGai[3](
    each k=0)
    "Internal heat gains, set to zero because these are modeled in EnergyPlus"
    annotation (Placement(transformation(origin = {186, 38}, extent = {{-40, 0}, {-20, 20}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tanHot(
    m_flow_nominal=mWater_flow_nominal,
    VTan=0.1136,
    hTan=0.6548,
    dIns=0.0450,
    nSeg=20,
    redeclare package Medium = MediumWater,
    T_start=313.15) annotation (Placement(transformation(origin={-20,8}, extent
          ={{-10,-10},{10,10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {-86, 76}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov1(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {26, 80}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, 1})  annotation(
    Placement(transformation(origin = {-28, 94}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun1(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, -1})  annotation(
    Placement(transformation(origin = {-21, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(redeclare package Medium1 = MediumWater, redeclare package Medium2 = MediumAir, m1_flow_nominal = mWater_flow_nominal, m2_flow_nominal = mAir_flow_nominal, dp1_nominal = dpWater_nominal, dp2_nominal = dpAir_nominal, UA_nominal = 400)  annotation(
    Placement(transformation(origin={90.8647,26.9798},    extent = {{13.2434, -19.4055}, {-13.2434, 19.4055}}, rotation = 90)));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov11(redeclare package Medium = MediumAir, addPowerToMedium = false, m_flow_nominal = mAir_flow_nominal)  annotation(
    Placement(transformation(origin = {103, 75}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, dpValve_nominal = dpValve_nominal) annotation(
    Placement(transformation(origin = {-4, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, dpValve_nominal = dpValve_nominal) annotation(
    Placement(transformation(origin = {7, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, dpValve_nominal = dpValve_nominal) annotation(
    Placement(transformation(origin = {-58, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val3(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, dpValve_nominal = dpValve_nominal) annotation(
    Placement(transformation(origin = {-52, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)    annotation(
    Placement(transformation(origin={-262,-10},  extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k = mAir_flow_nominal)  annotation(
    Placement(transformation(origin = {67, 108}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.TimeTable dailyScheduleTable(table = [0, 1; 2, 0; 4, 1; 8, 3; 12, 2; 16, 4; 21, 1; 24, 1], timeScale = 3600, period = 86400)  annotation(
    Placement(transformation(origin={-244,150},    extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tanCold(
    redeclare package Medium = MediumWater,
    VTan=0.1136,
    dIns=0.0450,
    hTan=0.6548,
    m_flow_nominal=mWater_flow_nominal,
    nSeg=20,
    T_start=282.15) annotation (Placement(transformation(origin={-58,13},
          extent={{-10,-10},{10,10}})));
  Controls.hvac_storage_controller hvac_storage_controller
    annotation (Placement(transformation(extent={{-174,114},{-154,134}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=0.5) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-86,116})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=0.5) annotation (
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
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea
    annotation (Placement(transformation(extent={{262,92},{282,112}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea1
    annotation (Placement(transformation(extent={{150,98},{170,118}})));
  Buildings.Fluid.HeatExchangers.SensibleCooler_T coo
    annotation (Placement(transformation(extent={{192,98},{212,118}})));
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
  connect(freshAir.ports[1], duc.port_b) annotation(
    Line(points = {{166, -2}, {176, -2}}, color = {0, 127, 255}));
  connect(duc.port_a, zon.ports[1]) annotation(
    Line(points={{196,-2},{204.5,-2},{204.5,18.9}},    color = {0, 127, 255}));
  connect(bou.ports[1], zon.ports[2]) annotation(
    Line(points={{166,-42},{205.5,-42},{205.5,18.9}},    color = {0, 127, 255}));
  connect(zon.qGai_flow, qIntGai.y) annotation(
    Line(points = {{184, 48}, {167, 48}}, color = {0, 0, 127}));
  connect(building.weaBus, bou.weaBus) annotation(
    Line(points = {{114, -44}, {114, -41.8}, {146, -41.8}}, color = {255, 204, 51}, thickness = 0.5));
  connect(simple_heat_pump_2d.port_b, mov.port_a) annotation(
    Line(points={{-115.2,29.4},{-96,29.4},{-96,76}},  color = {0, 127, 255}));
  connect(mov.port_b, jun.port_1) annotation(
    Line(points = {{-76, 76}, {-52, 76}, {-52, 94}, {-38, 94}}, color = {0, 127, 255}));
  connect(jun.port_2, mov1.port_a) annotation(
    Line(points = {{-18, 94}, {16, 94}, {16, 80}}, color = {0, 127, 255}));
  connect(mov1.port_b, cooCoi.port_a1) annotation(
    Line(points={{36,80},{79.2214,80},{79.2214,40.2232}},
                                                  color = {0, 127, 255}));
  connect(cooCoi.port_b1, jun1.port_1) annotation(
    Line(points={{79.2214,13.7364},{79.2214,-64},{-11,-64}},
                                                     color = {0, 127, 255}));
  connect(jun1.port_2, simple_heat_pump_2d.port_a) annotation(
    Line(points={{-31,-64},{-166,-64},{-166,29.4},{-157,29.4}},      color = {0, 127, 255}));
  connect(mov11.port_a, cooCoi.port_b2) annotation(
    Line(points={{103,65},{103,54},{102.508,54},{102.508,40.2232}},
                                                                color = {0, 127, 255}));
  connect(mov11.port_b, zon.ports[3]) annotation(
    Line(points={{103,85},{204,85},{204,18.9},{206.5,18.9}},    color = {0, 127, 255}));
  connect(cooCoi.port_a2, zon.ports[4]) annotation(
    Line(points={{102.508,13.7364},{102.508,-24},{207.5,-24},{207.5,18.9}},
                                                                  color = {0, 127, 255}));
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
  connect(con2.y, mov11.m_flow_in) annotation(
    Line(points={{79,108},{91,108},{91,75}},        color = {0, 0, 127}));
  connect(building.weaBus.TDryBul, heaPumPer.TOut) annotation(
    Line(points={{114,-44},{124,-44},{124,-92},{-214,-92},{-214,25.4},{-200,
          25.4}},                                                                            color = {0, 0, 127}));
  connect(val2.port_b, tanCold.port_b) annotation (Line(points={{-58,38},{-78,
          38},{-78,3},{-58,3}}, color={0,127,255}));
  connect(tanCold.port_a, val3.port_a) annotation (Line(points={{-58,23},{-46,
          23},{-46,-14},{-52,-14}}, color={0,127,255}));
  connect(gai.y, mov.m_flow_in)
    annotation (Line(points={{-86,104},{-86,104},{-86,88}}, color={0,0,127}));
  connect(gai1.y, mov1.m_flow_in) annotation (Line(points={{28,104},{26,104},{
          26,92},{26,92}}, color={0,0,127}));
  connect(dailyScheduleTable.y[1], hvac_storage_controller.systemCommand)
    annotation (Line(points={{-232,150},{-204,150},{-204,131.8},{-176,131.8}},
        color={255,127,0}));
  connect(hvac_storage_controller.HotTesValve, val.y) annotation (Line(points={
          {-152,134.6},{-98,134.6},{-98,140},{8,140},{8,46}}, color={0,0,127}));
  connect(val.y, val1.y) annotation (Line(points={{8,46},{20,46},{20,44},{28,44},
          {28,-22},{19,-22}}, color={0,0,127}));
  connect(val2.y, val3.y) annotation (Line(points={{-46,48},{-32,48},{-32,-24},
          {-40,-24}}, color={0,0,127}));
  connect(hvac_storage_controller.ColdTesValve, val2.y)
    annotation (Line(points={{-152,132},{-46,132},{-46,48}}, color={0,0,127}));
  connect(hvac_storage_controller.HPMode, simple_heat_pump_2d.HeaPumMod)
    annotation (Line(points={{-151.8,118.8},{-142,118.8},{-142,118},{-108,118},
          {-108,23.4},{-114.8,23.4}}, color={255,0,255}));
  connect(hvac_storage_controller.HPOnOff, simple_heat_pump_2d.HeaPumOnOff)
    annotation (Line(points={{-152,115.8},{-150,115.8},{-150,25.4},{-157.2,25.4}},
        color={255,0,255}));
  connect(hvac_storage_controller.HeatPumpSidePumpFraction, gai.u) annotation (
      Line(points={{-152,129.6},{-120,129.6},{-120,128},{-86,128}}, color={0,0,
          127}));
  connect(hvac_storage_controller.LoadSidePumpFraction, gai1.u) annotation (
      Line(points={{-152,126.4},{-88,126.4},{-88,114},{18,114},{18,128},{28,128}},
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
        points={{-152,123},{-144,123},{-144,122},{-240,122},{-240,8}}, color={0,
          0,127}));
  connect(hvac_storage_controller.HeatPumpSetpoint, max1.u2) annotation (Line(
        points={{-152,123},{-140,123},{-140,124},{-132,124},{-132,-52},{-240,
          -52}}, color={0,0,127}));
  connect(bou1.ports[1], jun1.port_3) annotation (Line(points={{-92,-46},{-21,
          -46},{-21,-54}}, color={0,127,255}));
  annotation(
    experiment(StartTime = 0, StopTime = 432000, Tolerance = 1e-06, Interval = 60),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"),
  Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end hvac_water_storage_example_original;
