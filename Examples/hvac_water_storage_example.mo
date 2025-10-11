within hvac_storage_building.Examples;

model hvac_water_storage_example
  extends Modelica.Icons.Example;
  HeatPumps.simple_heat_pump_2d simple_heat_pump_2d(redeclare package Medium_con = MediumWater, mCon_flow_nominal = mWater_flow_nominal)  annotation(
    Placement(transformation(origin = {-136, 26}, extent = {{-20, -20}, {20, 20}})));
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
  Buildings.Fluid.Storage.StratifiedEnhanced tan(m_flow_nominal = mWater_flow_nominal, VTan = 1.5, hTan = 1.5, dIns = 0.02, nSeg = 20, redeclare package Medium = MediumWater)  annotation(
    Placement(transformation(origin = {-20, 8}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {-86, 76}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov1(redeclare package Medium = MediumWater, m_flow_nominal = mWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {26, 80}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, 1})  annotation(
    Placement(transformation(origin = {-28, 94}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun1(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, -1})  annotation(
    Placement(transformation(origin = {-21, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(redeclare package Medium1 = MediumWater, redeclare package Medium2 = MediumAir, m1_flow_nominal = mWater_flow_nominal, m2_flow_nominal = mAir_flow_nominal, dp1_nominal = dpWater_nominal, dp2_nominal = dpAir_nominal, UA_nominal = 400)  annotation(
    Placement(transformation(origin = {90.8647, 28.9798}, extent = {{13.2434, -19.4055}, {-13.2434, 19.4055}}, rotation = 90)));
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k = 273.15 + 50)  annotation(
    Placement(transformation(origin = {-192, 4}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k = 273.15 + 7)  annotation(
    Placement(transformation(origin = {-194, -30}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k = mAir_flow_nominal)  annotation(
    Placement(transformation(origin = {67, 108}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.TimeTable dailyScheduleTable(table = [0, 1; 2, 0; 4, 1; 8, 3; 12, 2; 16, 4; 21, 1; 24, 1], timeScale = 3600, period = 86400)  annotation(
    Placement(transformation(origin = {-160, 142}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tan1(redeclare package Medium = MediumWater, VTan = 1.5, dIns = 0.02, hTan = 1.5, m_flow_nominal = mWater_flow_nominal, nSeg = 20) annotation(
    Placement(transformation(origin = {-58, 13}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(heaPumPer.MaxHeaPumCapHea, simple_heat_pump_2d.MaxHeaPumCapHea) annotation(
    Line(points = {{-176, 39.2}, {-166, 39.2}, {-166, 45.2}, {-158, 45.2}}, color = {0, 0, 127}));
  connect(heaPumPer.MaxHeaPumCapCoo, simple_heat_pump_2d.MaxHeaPumCapCoo) annotation(
    Line(points = {{-176, 36.6}, {-164, 36.6}, {-164, 42.6}, {-158, 42.6}}, color = {0, 0, 127}));
  connect(heaPumPer.MinHeaPumCapHea, simple_heat_pump_2d.MinHeaPumCapHea) annotation(
    Line(points = {{-176, 33.6}, {-168, 33.6}, {-168, 37.6}, {-158, 37.6}}, color = {0, 0, 127}));
  connect(heaPumPer.MinHeaPumCapCoo, simple_heat_pump_2d.MinHeaPumCapCoo) annotation(
    Line(points = {{-176, 31}, {-162, 31}, {-162, 33}, {-156, 33}}, color = {0, 0, 127}));
  connect(heaPumPer.COPHea, simple_heat_pump_2d.COPHea) annotation(
    Line(points = {{-176, 25.4}, {-168, 25.4}, {-168, 21.4}, {-158, 21.4}}, color = {0, 0, 127}));
  connect(heaPumPer.COPCoo, simple_heat_pump_2d.COPCoo) annotation(
    Line(points = {{-176, 21.6}, {-174, 21.6}, {-174, 17.6}, {-158, 17.6}}, color = {0, 0, 127}));
  connect(heaPumPer.TSup, simple_heat_pump_2d.TSup) annotation(
    Line(points = {{-199.6, 35.6}, {-209.6, 35.6}, {-209.6, 55.6}, {-135.6, 55.6}, {-135.6, 47.6}}, color = {0, 0, 127}));
  connect(freshAir.ports[1], duc.port_b) annotation(
    Line(points = {{166, -2}, {176, -2}}, color = {0, 127, 255}));
  connect(duc.port_a, zon.ports[1]) annotation(
    Line(points = {{196, -2}, {204, -2}, {204, 18.9}}, color = {0, 127, 255}));
  connect(bou.ports[1], zon.ports[2]) annotation(
    Line(points = {{166, -42}, {208, -42}, {208, 18.9}}, color = {0, 127, 255}));
  connect(zon.qGai_flow, qIntGai.y) annotation(
    Line(points = {{184, 48}, {167, 48}}, color = {0, 0, 127}));
  connect(building.weaBus, bou.weaBus) annotation(
    Line(points = {{114, -44}, {114, -41.8}, {146, -41.8}}, color = {255, 204, 51}, thickness = 0.5));
  connect(simple_heat_pump_2d.port_b, mov.port_a) annotation(
    Line(points = {{-116, 30}, {-96, 30}, {-96, 76}}, color = {0, 127, 255}));
  connect(mov.port_b, jun.port_1) annotation(
    Line(points = {{-76, 76}, {-52, 76}, {-52, 94}, {-38, 94}}, color = {0, 127, 255}));
  connect(jun.port_2, mov1.port_a) annotation(
    Line(points = {{-18, 94}, {16, 94}, {16, 80}}, color = {0, 127, 255}));
  connect(mov1.port_b, cooCoi.port_a1) annotation(
    Line(points = {{36, 80}, {80, 80}, {80, 42}}, color = {0, 127, 255}));
  connect(cooCoi.port_b1, jun1.port_1) annotation(
    Line(points = {{80, 16}, {80, -64}, {-11, -64}}, color = {0, 127, 255}));
  connect(jun1.port_2, simple_heat_pump_2d.port_a) annotation(
    Line(points = {{-31, -64}, {-166, -64}, {-166, 30}, {-156, 30}}, color = {0, 127, 255}));
  connect(mov11.port_a, cooCoi.port_b2) annotation(
    Line(points = {{104, 66}, {104, 54}, {102, 54}, {102, 42}}, color = {0, 127, 255}));
  connect(mov11.port_b, zon.ports[3]) annotation(
    Line(points = {{104, 86}, {204, 86}, {204, 18}, {206, 18}}, color = {0, 127, 255}));
  connect(cooCoi.port_a2, zon.ports[4]) annotation(
    Line(points = {{102, 16}, {102, -24}, {206, -24}, {206, 18}}, color = {0, 127, 255}));
  connect(jun.port_3, val.port_a) annotation(
    Line(points = {{-28, 84}, {-4, 84}, {-4, 56}}, color = {0, 127, 255}));
  connect(val.port_b, tan.port_a) annotation(
    Line(points = {{-4, 36}, {-20, 36}, {-20, 18}}, color = {0, 127, 255}));
  connect(tan.port_b, val1.port_a) annotation(
    Line(points = {{-20, -2}, {8, -2}, {8, -12}}, color = {0, 127, 255}));
  connect(val1.port_b, jun1.port_3) annotation(
    Line(points = {{8, -32}, {-20, -32}, {-20, -54}}, color = {0, 127, 255}));
  connect(jun.port_3, val2.port_a) annotation(
    Line(points = {{-28, 84}, {-58, 84}, {-58, 58}}, color = {0, 127, 255}));
  connect(jun1.port_3, val3.port_b) annotation(
    Line(points = {{-20, -54}, {-52, -54}, {-52, -34}}, color = {0, 127, 255}));
  connect(con.y, simple_heat_pump_2d.TSupSetHea) annotation(
    Line(points = {{-180, 4}, {-170, 4}, {-170, 14}, {-158, 14}}, color = {0, 0, 127}));
  connect(con1.y, simple_heat_pump_2d.TSupSetCoo) annotation(
    Line(points = {{-182, -30}, {-158, -30}, {-158, 8}}, color = {0, 0, 127}));
  connect(con2.y, mov11.m_flow_in) annotation(
    Line(points = {{80, 108}, {92, 108}, {92, 76}}, color = {0, 0, 127}));
  connect(building.weaBus.TDryBul, heaPumPer.TOut) annotation(
    Line(points = {{114, -44}, {124, -44}, {124, -92}, {-214, -92}, {-214, 26}, {-200, 26}}, color = {0, 0, 127}));
  connect(val2.port_b, tan1.port_b) annotation(
    Line(points = {{-58, 38}, {-78, 38}, {-78, 4}, {-58, 4}}, color = {0, 127, 255}));
  connect(tan1.port_a, val3.port_a) annotation(
    Line(points = {{-58, 24}, {-46, 24}, {-46, -14}, {-52, -14}}, color = {0, 127, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 432000, Tolerance = 1e-06, Interval = 60),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"),
  Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end hvac_water_storage_example;
