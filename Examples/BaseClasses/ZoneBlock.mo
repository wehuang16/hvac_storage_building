within hvac_storage_building.Examples.BaseClasses;
block ZoneBlock

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
  Buildings.Fluid.MixingVolumes.MixingVolume volHea(
    redeclare package Medium = MediumAir,
    T_start=HeatingAmbientTemperature,
    m_flow_nominal=mHxAir_flow_nominal,
    V=ZoneAirVolume,
    nPorts=2) annotation (Placement(transformation(extent={{12,-8},{32,12}})));
  Buildings.Fluid.MixingVolumes.MixingVolume volCoo(
    redeclare package Medium = MediumAir,
    T_start=CoolingAmbientTemperature,
    m_flow_nominal=mHxAir_flow_nominal,
    V=ZoneAirVolume,
    nPorts=2)
    annotation (Placement(transformation(extent={{8,-76},{28,-56}})));
  Buildings.Fluid.FixedResistances.Junction junConv(
    redeclare package Medium = MediumAir,
    m_flow_nominal={mHxAir_flow_nominal,-1*mHxAir_flow_nominal,
        mHxAir_flow_nominal},
    dp_nominal={1,-1,1})
    annotation (Placement(transformation(extent={{66,-8},{86,12}})));
  Buildings.Controls.Continuous.LimPID conPIDHea(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-198,-40},{-178,-20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-38,-6},{-64,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{-26,-82},{-52,-56}})));
  Buildings.Controls.Continuous.LimPID conPIDCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    reverseActing=false)
    annotation (Placement(transformation(extent={{-198,-96},{-178,-76}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=
        HeatingAmbientTemperature)                                        annotation(
    Placement(transformation(origin={-236,-28},  extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=
        CoolingAmbientTemperature)                                        annotation(
    Placement(transformation(origin={-236,-90},  extent = {{-10, -10}, {10, 10}})));
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
  Buildings.Fluid.Movers.FlowControlled_m_flow movAirHea(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mHxAir_flow_nominal) annotation (Placement(transformation(
        origin={95,-95},
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
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloHea
    annotation (Placement(transformation(extent={{28,62},{48,82}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloCoo
    annotation (Placement(transformation(extent={{42,-150},{62,-130}})));
  SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{-10,118},{10,138}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{52,132},{72,152}})));
  ValueScaleDown valueScaleDownHea(uAtZero=HeatingScaleDownTemperature -
        ScaleDownHysteresis, uAtOne=HeatingScaleDownTemperature)
    annotation (Placement(transformation(extent={{134,136},{154,156}})));
  ValueScaleDown valueScaleDownCoo(uAtZero=CoolingScaleDownTemperature +
        ScaleDownHysteresis, uAtOne=CoolingScaleDownTemperature)
    annotation (Placement(transformation(extent={{-26,-178},{-6,-158}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=
        mHxAir_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={92,-138})));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium = MediumAir,
      nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={268,-44})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemAirIn(redeclare package
      Medium = MediumAir, m_flow_nominal=mHxAir_flow_nominal)
    annotation (Placement(transformation(extent={{116,-16},{136,4}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemAirOut(redeclare package
      Medium = MediumAir, m_flow_nominal=mHxAir_flow_nominal) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={172,-72})));
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
  Buildings.Controls.OBC.CDL.Reals.Switch swiHea
    annotation (Placement(transformation(extent={{-86,-48},{-66,-28}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=0)             annotation(
    Placement(transformation(origin={-150,-64},  extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow movAirCoo(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=mHxAir_flow_nominal) annotation (Placement(transformation(
        origin={107,-33},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Buildings.Fluid.FixedResistances.Junction junDiv(
    redeclare package Medium = MediumAir,
    m_flow_nominal={mHxAir_flow_nominal,-1*mHxAir_flow_nominal,-1*
        mHxAir_flow_nominal},
    dp_nominal={1,-1,-1}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={138,-66})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiCoo
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
  Buildings.Controls.OBC.CDL.Logical.And and2
    annotation (Placement(transformation(extent={{272,150},{292,170}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai2(k=
        mHxAir_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={168,-36})));
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
    annotation (Placement(transformation(extent={{218,76},{238,96}})));
equation
  connect(zonLoaReq, zoneThermalMode.ZonLoaReq)
    annotation (Line(points={{-120,72},{-58,72}}, color={0,0,127}));
  connect(volHea.ports[1], junConv.port_1) annotation (Line(points={{21,-8},{21,
          -16},{64,-16},{64,2},{66,2}}, color={0,127,255}));
  connect(volCoo.ports[1], junConv.port_3) annotation (Line(points={{17,-76},{
          17,-82},{76,-82},{76,-8}}, color={0,127,255}));
  connect(temperatureSensor.port, volHea.heatPort) annotation (Line(points={{-38,7},
          {6,7},{6,2},{12,2}},      color={191,0,0}));
  connect(temperatureSensor1.port, volCoo.heatPort) annotation (Line(points={{-26,-69},
          {-26,-70},{0,-70},{0,-66},{8,-66}},           color={191,0,0}));
  connect(temperatureSensor.T, conPIDHea.u_m) annotation (Line(points={{-65.3,7},
          {-94,7},{-94,-22},{-172,-22},{-172,-50},{-188,-50},{-188,-42}}, color
        ={0,0,127}));
  connect(temperatureSensor1.T, conPIDCoo.u_m) annotation (Line(points={{-53.3,
          -69},{-53.3,-70},{-90,-70},{-90,-108},{-188,-108},{-188,-98}}, color=
          {0,0,127}));
  connect(con.y, conPIDHea.u_s) annotation (Line(points={{-224,-28},{-208,-28},
          {-208,-30},{-200,-30}}, color={0,0,127}));
  connect(con1.y, conPIDCoo.u_s) annotation (Line(points={{-224,-90},{-208,-90},
          {-208,-86},{-200,-86}}, color={0,0,127}));
  connect(movWater.port_b, port_b) annotation (Line(points={{278,-152},{348,
          -152},{348,-160},{364,-160}}, color={0,127,255}));
  connect(con2.y, movWater.m_flow_in) annotation (Line(points={{293,-90},{302,-90},
          {302,-130},{268,-130},{268,-140}}, color={0,0,127}));
  connect(preHeaFloHea.port, volHea.heatPort) annotation (Line(points={{48,72},{
          54,72},{54,14},{38,14},{38,-14},{6,-14},{6,2},{12,2}},   color={191,0,
          0}));
  connect(preHeaFloCoo.port, volCoo.heatPort) annotation (Line(points={{62,-140},
          {68,-140},{68,-84},{8,-84},{8,-66}},
                                             color={191,0,0}));
  connect(zonLoaReq, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-120,72},{-66,72},{-66,128},{-12,128}}, color={0,
          0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy, gai.u)
    annotation (Line(points={{12,131.6},{42,131.6},{42,142},{50,142}},color={0,0,
          127}));
  connect(gai.y, valueScaleDownHea.uValToSca)
    annotation (Line(points={{74,142},{132,142}}, color={0,0,127}));
  connect(temperatureSensor.T, valueScaleDownHea.u) annotation (Line(points={{-65.3,7},
          {-78,7},{-78,158},{122,158},{122,150},{132,150}},
                                      color={0,0,127}));
  connect(valueScaleDownHea.yValSca, preHeaFloHea.Q_flow) annotation (Line(
        points={{156,142},{160,142},{160,96},{28,96},{28,72}}, color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy,
    valueScaleDownCoo.uValToSca) annotation (Line(points={{12,122.2},{22,122.2},
          {22,78},{-22,78},{-22,-172},{-28,-172}}, color={0,0,127}));
  connect(valueScaleDownCoo.yValSca, preHeaFloCoo.Q_flow) annotation (Line(
        points={{-4,-172},{14,-172},{14,-174},{42,-174},{42,-140}}, color={0,0,127}));
  connect(temperatureSensor1.T, valueScaleDownCoo.u) annotation (Line(points={{-53.3,
          -69},{-53.3,-70},{-90,-70},{-90,-160},{-38,-160},{-38,-164},{-28,-164}},
        color={0,0,127}));
  connect(bou1.ports[1], cooCoi.port_a2) annotation (Line(points={{258,-44},{
          242,-44},{242,-73.3769},{236.108,-73.3769}},
                                                   color={0,127,255}));
  connect(junConv.port_2, senTemAirIn.port_a) annotation (Line(points={{86,2},{
          104,2},{104,-6},{116,-6}}, color={0,127,255}));
  connect(senTemAirIn.port_b, cooCoi.port_a2) annotation (Line(points={{136,-6},
          {242,-6},{242,-73.3769},{236.108,-73.3769}}, color={0,127,255}));
  connect(cooCoi.port_b2, senTemAirOut.port_a) annotation (Line(points={{
          209.622,-73.3769},{188,-73.3769},{188,-72},{182,-72}}, color={0,127,
          255}));
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
  connect(senTemAirOut.port_b, junDiv.port_1) annotation (Line(points={{162,-72},
          {154,-72},{154,-66},{148,-66}}, color={0,127,255}));
  connect(junDiv.port_2, movAirHea.port_a) annotation (Line(points={{128,-66},{
          114,-66},{114,-95},{105,-95}}, color={0,127,255}));
  connect(junDiv.port_3, movAirCoo.port_a) annotation (Line(points={{138,-56},{
          138,-33},{117,-33}}, color={0,127,255}));
  connect(movAirCoo.port_b, volCoo.ports[2]) annotation (Line(points={{97,-33},
          {76,-33},{76,-82},{19,-82},{19,-76}}, color={0,127,255}));
  connect(movAirHea.port_b, volHea.ports[2]) annotation (Line(points={{85,-95},
          {85,-66},{54,-66},{54,-8},{23,-8}}, color={0,127,255}));
  connect(and2.y, swiHea.u2) annotation (Line(points={{294,160},{294,18},{-24,
          18},{-24,-50},{-60,-50},{-60,-54},{-96,-54},{-96,-38},{-88,-38}},
        color={255,0,255}));
  connect(conPIDHea.y, swiHea.u1) annotation (Line(points={{-177,-30},{-154,-30},
          {-154,-26},{-98,-26},{-98,-30},{-88,-30}}, color={0,0,127}));
  connect(hys.y, and2.u1) annotation (Line(points={{162,70},{250,70},{250,160},
          {270,160}}, color={255,0,255}));
  connect(not1.y, and2.u2)
    annotation (Line(points={{252,54},{270,54},{270,152}}, color={255,0,255}));
  connect(con3.y, swiHea.u3) annotation (Line(points={{-138,-64},{-88,-64},{-88,
          -46}}, color={0,0,127}));
  connect(gai2.y, movAirCoo.m_flow_in) annotation (Line(points={{156,-36},{124,
          -36},{124,-50},{116,-50},{116,-54},{107,-54},{107,-45}}, color={0,0,
          127}));
  connect(movAirHea.m_flow_in, gai1.y) annotation (Line(points={{95,-107},{80,
          -107},{80,-126},{92,-126}}, color={0,0,127}));
  connect(hys.y, not2.u) annotation (Line(points={{162,70},{262,70},{262,46},{
          260,46},{260,38},{268,38}}, color={255,0,255}));
  connect(not1.y, and1.u2) annotation (Line(points={{252,54},{250,54},{250,12},
          {332,12},{332,16}}, color={255,0,255}));
  connect(not2.y, and1.u1) annotation (Line(points={{292,38},{324,38},{324,24},
          {332,24}}, color={255,0,255}));
  connect(and1.y, swiCoo.u2) annotation (Line(points={{356,24},{370,24},{370,28},
          {-82,28},{-82,-100}}, color={255,0,255}));
  connect(conPIDCoo.y, swiCoo.u1) annotation (Line(points={{-177,-86},{-92,-86},
          {-92,-92},{-82,-92}}, color={0,0,127}));
  connect(con3.y, swiCoo.u3) annotation (Line(points={{-138,-64},{-94,-64},{-94,
          -116},{-82,-116},{-82,-108}}, color={0,0,127}));
  connect(swiHea.y, gai1.u) annotation (Line(points={{-64,-38},{78,-38},{78,
          -122},{76,-122},{76,-158},{92,-158},{92,-150}}, color={0,0,127}));
  connect(swiCoo.y, gai2.u) annotation (Line(points={{-58,-100},{204,-100},{204,
          -36},{180,-36}}, color={0,0,127}));
  connect(zoneThermalMode.yZonHeaCooMod, yZonHeaCooMod) annotation (Line(points
        ={{-34,72},{20,72},{20,56},{94,56},{94,50},{184,50},{184,-4},{354,-4},{
          354,-26},{380,-26}}, color={255,127,0}));
  connect(realExpression.y, zonLoaAct) annotation (Line(points={{239,86},{354,
          86},{354,76},{380,76}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -180},{360,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},{360,
            100}})));
end ZoneBlock;
