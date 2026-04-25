within hvac_storage_building.Examples.BaseClasses;
model HvacHotPcmStorage_WithWaterVolume

  parameter Integer numZon=1 "number of zones";
  parameter Real scaFacHeaPum=0.3 "scaling factor";

  parameter Real heatLossRatePcm=1 "heat loss rate in W/K";
  parameter Real heatLossRateVolumizer=0.06 "heat loss rate in W/K";

    parameter Real ZoneAirVolume=1000 "m3";
    parameter Real volumizerVolume=0.01 "m3";
    parameter Real heatPumpCyclingWaitTime=600 "s";
  parameter Real HeatingAmbientTemperature=273.15+22 "K";
  parameter Real CoolingAmbientTemperature=273.15+22 "K";
parameter Real InsideAirTemperature=273.15+22 "K";

    parameter Real HeatingTankFullTemperature=273.15+54 "K";
  parameter Real HeatingTankEmptyTemperature=273.15+40 "K";
  parameter Real CoolingTankFullTemperature=273.15+8 "K";
  parameter Real CoolingTankEmptyTemperature=273.15+15 "K";

  HeatPumps.simple_heat_pump_2d simple_heat_pump_2d(redeclare package
      Medium_con = MediumWater, mCon_flow_nominal=mSystemWater_flow_nominal,
    cycling_wait_time=heatPumpCyclingWaitTime)
    annotation (Placement(transformation(origin={-136,26}, extent={{-20,-20},{
            20,20}})));
  HeatPumps.BaseClasses.HeaPumPer_LG
                                  heaPumPer_LG(scaFac=scaFacHeaPum)
                                            annotation(
    Placement(transformation(origin = {-188, 30}, extent = {{-10, -10}, {10, 10}})));

  package MediumAir=Buildings.Media.Air
    "Medium model";

  package MediumWater = Buildings.Media.Water;
  package MediumPropyleneGlycol =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=273.15+20, X_a=
            0.4);
   parameter Modelica.Units.SI.MassFlowRate mSystemWater_flow_nominal=0.575 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mHxWater_flow_nominal=0.11827*4 "Nominal mass flow rate on the water side";
    parameter Modelica.Units.SI.MassFlowRate mHxAir_flow_nominal=0.14951*4 "Nominal mass flow rate on the air side";

    parameter Modelica.Units.SI.PressureDifference dpHxWater_nominal=50;

    parameter Modelica.Units.SI.PressureDifference dpHxAir_nominal=50;
parameter Modelica.Units.SI.ThermalConductance UA_nominal(min=0)=400
    "Thermal conductance at nominal flow, used to compute heat capacity";

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
  Controls.hvac_hot_pcm_storage_controller hvac_pcm_storage_controller
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
    V=volumizerVolume,
    nPorts=2*numZon+2) annotation (Placement(transformation(extent={{52,88},{72,108}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput outside_air_temperature
    annotation (Placement(transformation(extent={{-380,-20},{-340,20}}),
        iconTransformation(extent={{-380,-20},{-340,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ZonLoaAct[numZon]
    annotation (Placement(transformation(extent={{200,42},{240,84}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput ZonLoaReq[numZon] annotation
    (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-360,-90}), iconTransformation(extent={{-380,-90},{-340,-50}})));
  BaseClasses.VolumizerLoss volumizerLoss(heatLossRate=heatLossRateVolumizer)
    annotation (Placement(transformation(extent={{-2,170},{18,190}})));
  ZoneBlock3            zoneBlock[numZon](
    ZoneAirVolume=ZoneAirVolume,
    HeatingAmbientTemperature=HeatingAmbientTemperature,
    CoolingAmbientTemperature=CoolingAmbientTemperature,
    mHxWater_flow_nominal=mHxWater_flow_nominal,
    mHxAir_flow_nominal=mHxAir_flow_nominal,
    dpHxWater_nominal=dpHxWater_nominal,
    dpHxAir_nominal=dpHxAir_nominal,
    UA_nominal=UA_nominal,                redeclare package MediumAir =
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
      HeatingTankEmptyTemperature=HeatingTankEmptyTemperature,
    TankHysteresisTemperature=1)
    annotation (Placement(transformation(extent={{-278,192},{-258,212}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ZonLoaUns[numZon]
    "unserved zone load" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={220,-60})));
  UnservedLoadCalculation unservedLoadCalculation[numZon]
    annotation (Placement(transformation(extent={{160,-16},{180,4}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=numZon)
    annotation (Placement(transformation(extent={{208,16},{220,28}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ZonLoaUnsHeaSum
    "unserved zone load" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={284,-14})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ZonLoaUnsCooSum
    "unserved zone load" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={264,-102})));
  Modelica.Blocks.Math.MultiSum multiSum1(nu=numZon)
    annotation (Placement(transformation(extent={{184,-106},{196,-94}})));
  FmuPatch fmuPatch
    annotation (Placement(transformation(extent={{-450,-136},{-430,-116}})));
  Buildings.Controls.OBC.CDL.Reals.Average storage_room_air_temperature
    annotation (Placement(transformation(origin={-252,-80}, extent={{-10,-10},{
            10,10}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{-82,32},{-62,52}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=InsideAirTemperature)
                                                                          annotation(
    Placement(transformation(origin={-332,-140}, extent = {{-10, -10}, {10, 10}})));
  PCM_48C_Theoretical_block_WithWaterVolume
                            pCM_48C_Theoretical_block(
    redeclare package Medium = MediumWater,
    mPCM_flow_nominal=mSystemWater_flow_nominal,
    Tes_nominal(displayUnit="kWh") = 21600000) annotation (Placement(
        transformation(
        extent={{-13,-11},{13,11}},
        rotation=270,
        origin={-9,21})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature TA
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{-146,-194},{-126,-174}})));
  Buildings.HeatTransfer.Convection.Interior convHot(
    A=1,
    hFixed=heatLossRatePcm,
    til=Buildings.Types.Tilt.Wall)
    "Convective heat transfer"
    annotation (Placement(transformation(extent={{-78,-194},{-98,-174}})));
equation
  connect(heaPumPer_LG.MaxHeaPumCapHea, simple_heat_pump_2d.MaxHeaPumCapHea)
    annotation (Line(points={{-176,39.2},{-166,39.2},{-166,45.3},{-157.1,45.3}},
        color={0,0,127}));
  connect(heaPumPer_LG.MaxHeaPumCapCoo, simple_heat_pump_2d.MaxHeaPumCapCoo)
    annotation (Line(points={{-176,36.6},{-164,36.6},{-164,41.7},{-157.1,41.7}},
        color={0,0,127}));
  connect(heaPumPer_LG.MinHeaPumCapHea, simple_heat_pump_2d.MinHeaPumCapHea)
    annotation (Line(points={{-176,33.6},{-168,33.6},{-168,37.7},{-157.2,37.7}},
        color={0,0,127}));
  connect(heaPumPer_LG.MinHeaPumCapCoo, simple_heat_pump_2d.MinHeaPumCapCoo)
    annotation (Line(points={{-176,31},{-162,31},{-162,34.3},{-157,34.3}},
        color={0,0,127}));
  connect(heaPumPer_LG.COPHea, simple_heat_pump_2d.COPHea) annotation (Line(
        points={{-176,25.4},{-168,25.4},{-168,21.3},{-157.1,21.3}}, color={0,0,127}));
  connect(heaPumPer_LG.COPCoo, simple_heat_pump_2d.COPCoo) annotation (Line(
        points={{-176,21.6},{-174,21.6},{-174,17.1},{-157.1,17.1}}, color={0,0,127}));
  connect(heaPumPer_LG.TSup, simple_heat_pump_2d.TSup) annotation (Line(points={
          {-199.6,35.6},{-209.6,35.6},{-209.6,55.6},{-135.5,55.6},{-135.5,47.1}},
        color={0,0,127}));
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
  connect(hvac_pcm_storage_controller.HPOnOff, simple_heat_pump_2d.HeaPumOnOff)
    annotation (Line(points={{-156,143.8},{-150,143.8},{-150,25.4},{-157.2,25.4}},
        color={255,0,255}));
  connect(hvac_pcm_storage_controller.HeatPumpSidePumpFraction, gai.u)
    annotation (Line(points={{-156,157.6},{-120,157.6},{-120,128},{-86,128}},
        color={0,0,127}));
  connect(hvac_pcm_storage_controller.LoadSidePumpFraction, gai1.u) annotation
    (Line(points={{-156,154.4},{-88,154.4},{-88,114},{18,114},{18,128},{28,128}},
        color={0,0,127}));
  connect(con.y,max2. u2) annotation (Line(points={{-250,-10},{-244,-10},{-244,
          -4},{-240,-4}}, color={0,0,127}));
  connect(con.y,min1. u1) annotation (Line(points={{-250,-10},{-246,-10},{-246,
          -40},{-240,-40}}, color={0,0,127}));
  connect(max2.y, simple_heat_pump_2d.TSupSetHea) annotation (Line(points={{
          -216,2},{-188,2},{-188,13.1},{-157.3,13.1}}, color={0,0,127}));
  connect(min1.y, simple_heat_pump_2d.TSupSetCoo) annotation (Line(points={{
          -216,-46},{-188,-46},{-188,8.9},{-157.1,8.9}}, color={0,0,127}));
  connect(hvac_pcm_storage_controller.HeatPumpSetpoint, max2.u1) annotation (
      Line(points={{-156,151},{-144,151},{-144,122},{-240,122},{-240,8}}, color
        ={0,0,127}));
  connect(hvac_pcm_storage_controller.HeatPumpSetpoint, min1.u2) annotation (
      Line(points={{-156,151},{-140,151},{-140,124},{-132,124},{-132,-52},{-240,
          -52}}, color={0,0,127}));
  connect(bou1.ports[1], jun1.port_3) annotation (Line(points={{-92,-46},{-21,-46},
          {-21,-54}}, color={0,127,255}));
  connect(mov1.port_b, volumizer.ports[1]) annotation (Line(points={{36,80},{48,
          80},{48,88},{62,88}},   color={0,127,255}));
  connect(outside_air_temperature, heaPumPer_LG.TOut) annotation (Line(points={{
          -360,0},{-278,0},{-278,18},{-210,18},{-210,25.4},{-200,25.4}}, color={
          0,0,127}));
  connect(volumizer.ports[2], jun1.port_1) annotation (Line(points={{62,88},{56,
          88},{56,-80},{-11,-80},{-11,-64}}, color={0,127,255}));
  connect(volumizerLoss.port_a, volumizer.heatPort) annotation (Line(points={{18.6,
          180},{46,180},{46,98},{52,98}}, color={191,0,0}));
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
  connect(systemThermalMode.ySysHeaCooMod, hvac_pcm_storage_controller.loadRequest)
    annotation (Line(points={{91,-27},{91,196},{-192,196},{-192,155.8},{-180,155.8}},
        color={255,127,0}));
  connect(systemCommand, hvac_pcm_storage_controller.systemCommand) annotation
    (Line(points={{-360,62},{-194,62},{-194,159.8},{-180,159.8}}, color={255,127,
          0}));
  connect(heatingThermalStorageStatus.yStoMod, hvac_pcm_storage_controller.tesHotStatus)
    annotation (Line(points={{-256,202},{-190,202},{-190,149.6},{-180.2,149.6}},
        color={255,127,0}));
  connect(zoneBlock.zonLoaAct, unservedLoadCalculation.ZonLoaAct) annotation (
      Line(points={{135.478,60.2857},{135.478,-11.9},{158,-11.9}}, color={0,0,127}));
  connect(ZonLoaReq, unservedLoadCalculation.ZonLoaReq) annotation (Line(points
        ={{-360,-90},{-280,-90},{-280,-154},{98,-154},{98,-110},{114,-110},{114,
          0},{158,0}}, color={0,0,127}));
  connect(unservedLoadCalculation.ZonLoaUns, ZonLoaUns) annotation (Line(points
        ={{182,-6},{194,-6},{194,-60},{220,-60}}, color={0,0,127}));
  connect(unservedLoadCalculation.ZonLoaUnsHea, multiSum.u) annotation (Line(
        points={{181.8,-0.4},{202,-0.4},{202,22},{208,22}}, color={0,0,127}));
  connect(multiSum.y, ZonLoaUnsHeaSum) annotation (Line(points={{221.02,22},{
          256,22},{256,-14},{284,-14}}, color={0,0,127}));
  connect(unservedLoadCalculation.ZonLoaUnsCoo, multiSum1.u) annotation (Line(
        points={{181.8,-15.4},{181.8,-90},{180,-90},{180,-100},{184,-100}},
        color={0,0,127}));
  connect(multiSum1.y, ZonLoaUnsCooSum) annotation (Line(points={{197.02,-100},
          {238,-100},{238,-102},{264,-102}}, color={0,0,127}));
  connect(storage_room_air_temperature.y, volumizerLoss.inside_air_temperature)
    annotation (Line(points={{-240,-80},{-96,-80},{-96,180},{-4,180}}, color={0,
          0,127}));
  connect(con1.y, simple_heat_pump_2d.HeaPumMod) annotation (Line(points={{-60,42},
          {-48,42},{-48,23.4},{-114.8,23.4}}, color={255,0,255}));
  connect(outside_air_temperature, storage_room_air_temperature.u1) annotation
    (Line(points={{-360,0},{-313,0},{-313,-74},{-264,-74}}, color={0,0,127}));
  connect(con2.y, storage_room_air_temperature.u2) annotation (Line(points={{
          -320,-140},{-294,-140},{-294,-86},{-264,-86}}, color={0,0,127}));
  connect(jun.port_3, pCM_48C_Theoretical_block.port_a) annotation (Line(points
        ={{-28,84},{-28,40},{-0.4,40},{-0.4,34.4}}, color={0,127,255}));
  connect(pCM_48C_Theoretical_block.port_b, jun1.port_3) annotation (Line(
        points={{-0.2,7.6},{-0.2,-48},{-21,-48},{-21,-54}}, color={0,127,255}));
  connect(TA.port,convHot. fluid)
    annotation (Line(points={{-126,-184},{-98,-184}},
                                                color={191,0,0}));
  connect(convHot.solid, pCM_48C_Theoretical_block.heaPorOutside) annotation (
      Line(points={{-78,-184},{22,-184},{22,19.2},{2.4,19.2}}, color={191,0,0}));
  connect(storage_room_air_temperature.y, TA.T) annotation (Line(points={{-240,-80},
          {-232,-80},{-232,-184},{-148,-184}}, color={0,0,127}));
  connect(pCM_48C_Theoretical_block.TPCM, heatingThermalStorageStatus.TSto)
    annotation (Line(points={{-4.8,7},{-4.8,-34},{-400,-34},{-400,202},{-280.2,202}},
        color={0,0,127}));
  annotation(
    experiment(StartTime = 0, StopTime = 432000, Tolerance = 1e-06, Interval = 60),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "cvode", variableFilter = ".*"),
  Diagram(coordinateSystem(extent={{-340,-100},{200,100}})),
  Icon(coordinateSystem(extent={{-340,-100},{200,100}})));
end HvacHotPcmStorage_WithWaterVolume;
