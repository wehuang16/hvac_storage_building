within hvac_storage_building.Examples.BaseClasses;
model HvacWaterStorage2

  parameter Integer numZon=3 "number of zones";
  parameter Integer nSeg=20 "number of tank segments";
  parameter Real heatLossRateTank=5 "heat loss rate in W/K";
  parameter Real heatLossRateVolumizer=0.5 "heat loss rate in W/K";

    parameter Real ZoneAirVolume=1000 "m3";
  parameter Real HeatingAmbientTemperature=273.15+26 "K";
  parameter Real CoolingAmbientTemperature=273.15+18 "K";
  parameter Real HeatingScaleDownTemperature=273.15+22 "K";
  parameter Real CoolingScaleDownTemperature=273.15+22 "K";

    parameter Real HeatingTankFullTemperature=273.15+53 "K";
  parameter Real HeatingTankEmptyTemperature=273.15+28 "K";
  parameter Real CoolingTankFullTemperature=273.15+10 "K";
  parameter Real CoolingTankEmptyTemperature=273.15+16 "K";

  HeatPumps.simple_heat_pump_2d simple_heat_pump_2d(redeclare package
      Medium_con = MediumWater, mCon_flow_nominal=mSystemWater_flow_nominal)
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
   parameter Modelica.Units.SI.MassFlowRate mSystemWater_flow_nominal=0.8 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mHxWater_flow_nominal=0.15 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mHxAir_flow_nominal=0.4 "Nominal mass flow rate on the air side";

    parameter Modelica.Units.SI.PressureDifference dpSystemValve_nominal=100;

    parameter Modelica.Units.SI.PressureDifference dpHxWater_nominal=100;

    parameter Modelica.Units.SI.PressureDifference dpHxAir_nominal=100;
parameter Modelica.Units.SI.ThermalConductance UA_nominal(min=0)=400
    "Thermal conductance at nominal flow, used to compute heat capacity";
  parameter Modelica.Units.SI.Volume VRoo=453.1 "Room volume";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=VRoo*1.2*0.3/3600
    "Nominal mass flow rate";
  Buildings.Fluid.Storage.StratifiedEnhanced tanHot(
    m_flow_nominal=mSystemWater_flow_nominal,
    VTan=1,
    hTan=1.5,
    dIns=0.02,
    nSeg=nSeg,
    redeclare package Medium = MediumWater,
    T_start=(HeatingTankFullTemperature + HeatingTankEmptyTemperature)/2)
                    annotation (Placement(transformation(origin={-20,8}, extent
          ={{-10,-10},{10,10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {-86, 76}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov1(redeclare package Medium = MediumWater, m_flow_nominal = mSystemWater_flow_nominal, addPowerToMedium = false)  annotation(
    Placement(transformation(origin = {26, 80}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, 1})  annotation(
    Placement(transformation(origin = {-28, 94}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.FixedResistances.Junction jun1(redeclare package Medium = MediumWater, dp_nominal = {0, 0, 0}, m_flow_nominal = {1, -1, -1})  annotation(
    Placement(transformation(origin = {-21, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 20)    annotation(
    Placement(transformation(origin={-262,-10},  extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Storage.StratifiedEnhanced tanCold(
    redeclare package Medium = MediumWater,
    VTan=1,
    dIns=0.02,
    hTan=1.5,
    m_flow_nominal=mSystemWater_flow_nominal,
    nSeg=nSeg,
    T_start=(CoolingTankFullTemperature + CoolingTankEmptyTemperature)/2)
                    annotation (Placement(transformation(origin={-58,13},
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
  Buildings.Controls.OBC.CDL.Reals.Min min1
    annotation (Placement(transformation(extent={{-238,-56},{-218,-36}})));
  Buildings.Controls.OBC.CDL.Reals.Max max2
    annotation (Placement(transformation(extent={{-238,-8},{-218,12}})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        MediumWater, nPorts=1)
    annotation (Placement(transformation(extent={{-112,-56},{-92,-36}})));
  Buildings.Fluid.MixingVolumes.MixingVolume volumizer(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mSystemWater_flow_nominal,
    V=0.05,
    nPorts=2*numZon+2) annotation (Placement(transformation(extent={{52,88},{72,108}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput outside_air_temperature
    annotation (Placement(transformation(extent={{-380,-20},{-340,20}}),
        iconTransformation(extent={{-380,-20},{-340,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ZonLoaAct[numZon]
    annotation (Placement(transformation(extent={{200,42},{240,84}})));
  BaseClasses.TankLoss tankLossCold(nSeg=nSeg, heatLossRate=heatLossRateTank)
    annotation (Placement(transformation(extent={{-144,-114},{-124,-94}})));
  BaseClasses.TankLoss tankLossHot(nSeg=nSeg, heatLossRate=heatLossRateTank)
    annotation (Placement(transformation(extent={{-90,-146},{-70,-126}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput ZonLoaReq[numZon] annotation
    (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-360,-90}), iconTransformation(extent={{-380,-90},{-340,-50}})));
  BaseClasses.VolumizerLoss volumizerLoss(heatLossRate=heatLossRateVolumizer)
    annotation (Placement(transformation(extent={{-2,170},{18,190}})));
  BaseClasses.ZoneBlock zoneBlock[numZon](
    ZoneAirVolume=ZoneAirVolume,
    HeatingAmbientTemperature=HeatingAmbientTemperature,
    CoolingAmbientTemperature=CoolingAmbientTemperature,
    HeatingScaleDownTemperature=HeatingScaleDownTemperature,
    CoolingScaleDownTemperature=CoolingScaleDownTemperature,
    mHxWater_flow_nominal=mHxWater_flow_nominal,
    mHxAir_flow_nominal=mHxAir_flow_nominal,
                                          redeclare package MediumAir =
        MediumAir, redeclare package MediumWater = MediumWater)
    annotation (Placement(transformation(extent={{100,42},{134,62}})));
  BaseClasses.ZoneThermalMode zoneThermalMode[numZon] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={98,-90})));
  BaseClasses.SystemThermalMode systemThermalMode(numZon=numZon) annotation (
      Placement(transformation(
        extent={{-13,-10},{13,10}},
        rotation=90,
        origin={91,-42})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep(nout=
        numZon) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,2})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput systemCommand annotation (
      Placement(transformation(extent={{-380,42},{-340,82}}),
        iconTransformation(extent={{-380,42},{-340,82}})));
  HeatingThermalStorageStatus heatingThermalStorageStatus(
      HeatingTankFullTemperature=HeatingTankFullTemperature,
      HeatingTankEmptyTemperature=HeatingTankEmptyTemperature)
    annotation (Placement(transformation(extent={{-278,192},{-258,212}})));
  CoolingThermalStorageStatus coolingThermalStorageStatus(
      CoolingTankFullTemperature=CoolingTankFullTemperature,
      CoolingTankEmptyTemperature=CoolingTankEmptyTemperature)
    annotation (Placement(transformation(extent={{-278,140},{-258,160}})));
  TankAverageTemperature tankAverageTemperatureHot
    annotation (Placement(transformation(extent={{-318,190},{-298,210}})));
  TankAverageTemperature tankAverageTemperatureCold
    annotation (Placement(transformation(extent={{-316,140},{-296,160}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ZonLoaUns[numZon]
    "unserved zone load" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={220,-60})));
  UnservedLoadCalculation unservedLoadCalculation[numZon]
    annotation (Placement(transformation(extent={{160,-16},{180,4}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow mov2(
    redeclare package Medium = MediumWater,
    m_flow_nominal=mSystemWater_flow_nominal,
    addPowerToMedium=false)                                                                                                                                       annotation(
    Placement(transformation(origin={-8,48},     extent = {{-10, -10}, {10, 10}},
        rotation=90)));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai2(k=
        mSystemWater_flow_nominal)                                      annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,50})));
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
  connect(gai.y, mov.m_flow_in)
    annotation (Line(points={{-86,104},{-86,104},{-86,88}}, color={0,0,127}));
  connect(gai1.y, mov1.m_flow_in) annotation (Line(points={{28,104},{26,104},{
          26,92},{26,92}}, color={0,0,127}));
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
  connect(con.y,max2. u2) annotation (Line(points={{-250,-10},{-244,-10},{-244,
          -4},{-240,-4}}, color={0,0,127}));
  connect(con.y,min1. u1) annotation (Line(points={{-250,-10},{-246,-10},{-246,
          -40},{-240,-40}}, color={0,0,127}));
  connect(max2.y, simple_heat_pump_2d.TSupSetHea) annotation (Line(points={{
          -216,2},{-188,2},{-188,13.1},{-157.3,13.1}}, color={0,0,127}));
  connect(min1.y, simple_heat_pump_2d.TSupSetCoo) annotation (Line(points={{
          -216,-46},{-188,-46},{-188,8.9},{-157.1,8.9}}, color={0,0,127}));
  connect(hvac_storage_controller.HeatPumpSetpoint,max2. u1) annotation (Line(
        points={{-156,151},{-144,151},{-144,122},{-240,122},{-240,8}}, color={0,
          0,127}));
  connect(hvac_storage_controller.HeatPumpSetpoint,min1. u2) annotation (Line(
        points={{-156,151},{-140,151},{-140,124},{-132,124},{-132,-52},{-240,-52}},
                 color={0,0,127}));
  connect(bou1.ports[1], jun1.port_3) annotation (Line(points={{-92,-46},{-21,-46},
          {-21,-54}}, color={0,127,255}));
  connect(mov1.port_b, volumizer.ports[1]) annotation (Line(points={{36,80},{48,
          80},{48,88},{62,88}},   color={0,127,255}));
  connect(outside_air_temperature, heaPumPer.TOut) annotation (Line(points={{-360,0},
          {-278,0},{-278,18},{-210,18},{-210,25.4},{-200,25.4}},
                                                  color={0,0,127}));
  connect(tankLossCold.port_a, tanCold.heaPorVol) annotation (Line(points={{-123.4,
          -104},{-118,-104},{-118,-4},{-58,-4},{-58,13}}, color={191,0,0}));
  connect(tankLossHot.port_a, tanHot.heaPorVol) annotation (Line(points={{-69.4,
          -136},{-64,-136},{-64,-44},{-32,-44},{-32,-24},{-30,-24},{-30,-20},{-34,
          -20},{-34,-8},{-36,-8},{-36,8},{-20,8}}, color={191,0,0}));
  connect(outside_air_temperature, tankLossCold.outside_air_temperature)
    annotation (Line(points={{-360,0},{-278,0},{-278,-104},{-146,-104}},
        color={0,0,127}));
  connect(outside_air_temperature, tankLossHot.outside_air_temperature)
    annotation (Line(points={{-360,0},{-278,0},{-278,-104},{-154,-104},{-154,-136},
          {-92,-136}}, color={0,0,127}));
  connect(volumizer.ports[2], jun1.port_1) annotation (Line(points={{62,88},{56,
          88},{56,-80},{-11,-80},{-11,-64}}, color={0,127,255}));
  connect(volumizerLoss.port_a, volumizer.heatPort) annotation (Line(points={{18.6,
          180},{46,180},{46,98},{52,98}}, color={191,0,0}));
  connect(outside_air_temperature, volumizerLoss.outside_air_temperature)
    annotation (Line(points={{-360,0},{-278,0},{-278,18},{-224,18},{-224,152},{-188,
          152},{-188,180},{-4,180}},                         color={0,0,127}));
  connect(ZonLoaReq, zoneThermalMode.ZonLoaReq) annotation (Line(points={{-360,-90},
          {-280,-90},{-280,-154},{98,-154},{98,-102}},
                                           color={0,0,127}));
  connect(zoneThermalMode.yZonHeaCooMod, systemThermalMode.reqSpaCon)
    annotation (Line(points={{98,-78},{98,-66},{91,-66},{91,-57}}, color={255,127,
          0}));
  connect(intScaRep.u, systemThermalMode.ySysHeaCooMod) annotation (Line(points
        ={{80,-10},{80,-18},{91,-18},{91,-27}}, color={255,127,0}));
  connect(intScaRep.y, zoneBlock.ySysHeaCooMod) annotation (Line(points={{80,14},
          {80,56.7143},{98.5217,56.7143}}, color={255,127,0}));
  connect(zoneBlock.port_a, volumizer.ports[3:numZon+2]) annotation (Line(points={{99.7043,
          42.2857},{56,42.2857},{56,82},{62,82},{62,88}},     color={0,127,255}));
  connect(zoneBlock.port_b, volumizer.ports[numZon+3:2*numZon+2]) annotation (Line(points={{134.296,
          43.4286},{164,43.4286},{164,88},{62,88}},   color={0,127,255}));
  connect(ZonLoaReq, zoneBlock.zonLoaReq) annotation (Line(points={{-360,-90},{
          -280,-90},{-280,-154},{98,-154},{98,-110},{114,-110},{114,36},{94,36},
          {94,60},{98.5217,60}},                    color={0,0,127}));
  connect(zoneBlock.zonLoaAct, ZonLoaAct) annotation (Line(points={{135.478,
          60.2857},{194,60.2857},{194,63},{220,63}},
                                            color={0,0,127}));
  connect(systemThermalMode.ySysHeaCooMod, hvac_storage_controller.loadRequest)
    annotation (Line(points={{91,-27},{91,196},{-192,196},{-192,155.8},{-180,155.8}},
        color={255,127,0}));
  connect(systemCommand, hvac_storage_controller.systemCommand) annotation (
      Line(points={{-360,62},{-194,62},{-194,159.8},{-180,159.8}},   color={255,
          127,0}));
  connect(heatingThermalStorageStatus.yStoMod, hvac_storage_controller.tesHotStatus)
    annotation (Line(points={{-256,202},{-190,202},{-190,149.6},{-180.2,149.6}},
        color={255,127,0}));
  connect(coolingThermalStorageStatus.yStoMod, hvac_storage_controller.tesColdStatus)
    annotation (Line(points={{-256,150},{-192,150},{-192,143.8},{-180,143.8}},
        color={255,127,0}));
  connect(tankAverageTemperatureHot.avgTem, heatingThermalStorageStatus.TSto)
    annotation (Line(points={{-296,200},{-288,200},{-288,202},{-280.2,202}},
        color={0,0,127}));
  connect(tankAverageTemperatureCold.avgTem, coolingThermalStorageStatus.TSto)
    annotation (Line(points={{-294,150},{-280.2,150}}, color={0,0,127}));
  connect(tanCold.heaPorVol, tankAverageTemperatureCold.port_a) annotation (
      Line(points={{-58,13},{-200,13},{-200,78},{-340,78},{-340,150},{-316.6,150}},
        color={191,0,0}));
  connect(tanHot.heaPorVol, tankAverageTemperatureHot.port_a) annotation (Line(
        points={{-20,8},{-144,8},{-144,58},{-356,58},{-356,200},{-318.6,200}},
        color={191,0,0}));
  connect(zoneBlock.zonLoaAct, unservedLoadCalculation.ZonLoaAct) annotation (
      Line(points={{135.478,60.2857},{135.478,-11.9},{158,-11.9}}, color={0,0,127}));
  connect(ZonLoaReq, unservedLoadCalculation.ZonLoaReq) annotation (Line(points
        ={{-360,-90},{-280,-90},{-280,-154},{98,-154},{98,-110},{114,-110},{114,
          0},{158,0}}, color={0,0,127}));
  connect(unservedLoadCalculation.ZonLoaUns, ZonLoaUns) annotation (Line(points
        ={{182,-6},{194,-6},{194,-60},{220,-60}}, color={0,0,127}));
  connect(tanHot.port_b, jun1.port_3) annotation (Line(points={{-20,-2},{-20,
          -46},{-21,-46},{-21,-54}}, color={0,127,255}));
  connect(jun.port_3, tanCold.port_b) annotation (Line(points={{-28,84},{-28,24},
          {-38,24},{-38,-2},{-58,-2},{-58,3}}, color={0,127,255}));
  connect(tanCold.port_a, jun1.port_3) annotation (Line(points={{-58,23},{-74,
          23},{-74,-54},{-21,-54}}, color={0,127,255}));
  connect(mov2.port_a, tanHot.port_a) annotation (Line(points={{-8,38},{-8,24},
          {-20,24},{-20,18}}, color={0,127,255}));
  connect(mov2.port_b, jun.port_3) annotation (Line(points={{-8,58},{-8,78},{
          -28,78},{-28,84}}, color={0,127,255}));
  connect(gai2.y, mov2.m_flow_in) annotation (Line(points={{-36,50},{-26,50},{
          -26,48},{-20,48}}, color={0,0,127}));
  connect(hvac_storage_controller.HotTesValve, gai2.u) annotation (Line(points=
          {{-156,162.6},{-66,162.6},{-66,58},{-68,58},{-68,50},{-60,50}}, color
        ={0,0,127}));
  annotation(
    experiment(StartTime = 0, StopTime = 432000, Tolerance = 1e-06, Interval = 60),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"),
  Diagram(coordinateSystem(extent={{-340,-100},{200,100}})),
  Icon(coordinateSystem(extent={{-340,-100},{200,100}})));
end HvacWaterStorage2;
