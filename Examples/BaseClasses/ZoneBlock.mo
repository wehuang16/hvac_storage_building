within hvac_storage_building.Examples.BaseClasses;
block ZoneBlock

  parameter Real ZoneAirVolume=1000 "m3";
  parameter Real HeatingAmbientTemperature=273.15+26 "K";
  parameter Real CoolingAmbientTemperature=273.15+18 "K";
  parameter Real HeatingScaleDownTemperature=273.15+22 "K";
  parameter Real CoolingScaleDownTemperature=273.15+22 "K";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1;

  parameter Modelica.Units.SI.Pressure dpValve_nominal=10;

  replaceable package MediumAir=Buildings.Media.Air
    "Medium model";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput zone_load_request annotation
    (Placement(transformation(
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
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput fanPid annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,64})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{-114,-80},{-94,-60}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{94,-82},{114,-62}})));
  Buildings.Fluid.MixingVolumes.MixingVolume volHea(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    V=ZoneAirVolume,
    nPorts=2) annotation (Placement(transformation(extent={{26,18},{46,38}})));
  Buildings.Fluid.MixingVolumes.MixingVolume volCoo(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    V=ZoneAirVolume,
    nPorts=2)
    annotation (Placement(transformation(extent={{12,-120},{32,-100}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = MediumAir,             m_flow_nominal=
        m_flow_nominal,
    dpValve_nominal=dpValve_nominal)                  annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=0,
        origin={-46,-66})));
  Buildings.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = MediumAir,
    m_flow_nominal={m_flow_nominal,-1*m_flow_nominal,m_flow_nominal},
    dp_nominal={dpValve_nominal,-1*dpValve_nominal,dpValve_nominal})
    annotation (Placement(transformation(extent={{52,-68},{72,-48}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-64,-4},{-44,16}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{8,18},{-18,44}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{-4,-120},{-30,-94}})));
  Buildings.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=300,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    reverseActing=true)
    annotation (Placement(transformation(extent={{-70,-154},{-50,-134}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=
        HeatingAmbientTemperature)                                        annotation(
    Placement(transformation(origin={-112,-4},   extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=
        CoolingAmbientTemperature)                                        annotation(
    Placement(transformation(origin={-104,-142}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(zone_load_request, zoneThermalMode.zone_load_request) annotation (
      Line(points={{-120,72},{-58,72}},                   color={0,0,127}));
  connect(val.port_1, volHea.ports[1])
    annotation (Line(points={{-34,-66},{35,-66},{35,18}}, color={0,127,255}));
  connect(val.port_3, volCoo.ports[1]) annotation (Line(points={{-46,-78},{-46,-126},
          {21,-126},{21,-120}}, color={0,127,255}));
  connect(volHea.ports[2], jun.port_1)
    annotation (Line(points={{37,18},{37,-58},{52,-58}}, color={0,127,255}));
  connect(volCoo.ports[2], jun.port_3) annotation (Line(points={{23,-120},{23,-122},
          {22,-122},{22,-126},{62,-126},{62,-68}}, color={0,127,255}));
  connect(jun.port_2, port_b) annotation (Line(points={{72,-58},{88,-58},{88,
          -72},{104,-72}},
                      color={0,127,255}));
  connect(temperatureSensor.port, volHea.heatPort) annotation (Line(points={{8,31},
          {22,31},{22,28},{26,28}}, color={191,0,0}));
  connect(temperatureSensor1.port, volCoo.heatPort) annotation (Line(points={{-4,
          -107},{-4,-108},{8,-108},{8,-110},{12,-110}}, color={191,0,0}));
  connect(temperatureSensor.T, conPID.u_m) annotation (Line(points={{-19.3,31},{
          -19.3,-6},{-54,-6}}, color={0,0,127}));
  connect(temperatureSensor1.T, conPID1.u_m) annotation (Line(points={{-31.3,-107},
          {-31.3,-156},{-60,-156}}, color={0,0,127}));
  connect(con.y, conPID.u_s) annotation (Line(points={{-100,-4},{-74,-4},{-74,6},
          {-66,6}}, color={0,0,127}));
  connect(con1.y, conPID1.u_s) annotation (Line(points={{-92,-142},{-80,-142},{-80,
          -144},{-72,-144}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ZoneBlock;
