within hvac_storage_building.Sensors;
model ThermalPowerFlowSensor
 replaceable package Medium = Buildings.Media.Water "Medium in the component";
  Modelica.Blocks.Math.MultiProduct Q_flow_calculated(nu=3)
    annotation (Placement(transformation(extent={{110,-44},{122,-32}})));
  Modelica.Blocks.Math.Add deltaT(k2=-1)
    annotation (Placement(transformation(extent={{42,-50},{62,-30}})));
  Modelica.Blocks.Math.Gain HeatCapacity(k=1)
    annotation (Placement(transformation(extent={{-12,-68},{8,-48}})));
  Buildings.Fluid.HeatExchangers.Heater_T hea1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{-40,-92},{-20,-72}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 21)
    annotation (Placement(transformation(extent={{-88,-68},{-68,-48}})));
  Buildings.Fluid.Sensors.MassFlowRate MassFlow(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-48,44},{-28,64}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TempReturn(redeclare package
      Medium = Medium, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{6,46},{26,66}})));
  Modelica.Blocks.Interfaces.RealInput TempSupply "p" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={2,112})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-112,-14},{-92,6}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{92,-14},{112,6}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,-110})));
 Buildings.Fluid.Sources.MassFlowSource_T sou2(nPorts = 1, redeclare package Medium = Medium, m_flow = 1)  annotation(
    Placement(transformation(origin = {-140, -68}, extent = {{-10, -10}, {10, 10}})));
 Buildings.Fluid.Sources.Boundary_pT bou1(nPorts = 1, redeclare package Medium = Medium)  annotation(
    Placement(transformation(origin = {106, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  connect(deltaT.y, Q_flow_calculated.u[1]) annotation(
    Line(points = {{63, -40}, {63, -39.4}, {110, -39.4}}, color = {0, 0, 127}));
  connect(HeatCapacity.y, Q_flow_calculated.u[2]) annotation(
    Line(points = {{9, -58}, {96, -58}, {96, -38}, {110, -38}}, color = {0, 0, 127}));
  connect(const1.y, hea1.TSet) annotation(
    Line(points = {{-67, -58}, {-50, -58}, {-50, -74}, {-42, -74}}, color = {0, 0, 127}));
  connect(hea1.Q_flow, HeatCapacity.u) annotation(
    Line(points = {{-19, -74}, {-19, -68}, {-14, -68}, {-14, -58}}, color = {0, 0, 127}));
  connect(port_a, MassFlow.port_a) annotation(
    Line(points = {{-102, -4}, {-54, -4}, {-54, 54}, {-48, 54}}, color = {0, 127, 255}));
  connect(MassFlow.port_b, TempReturn.port_a) annotation(
    Line(points = {{-28, 54}, {-26, 54}, {-26, 56}, {6, 56}}, color = {0, 127, 255}));
  connect(TempReturn.port_b, port_b) annotation(
    Line(points = {{26, 56}, {88, 56}, {88, -4}, {102, -4}}, color = {0, 127, 255}));
  connect(TempReturn.T, deltaT.u2) annotation(
    Line(points = {{16, 67}, {18, 67}, {18, 74}, {24, 74}, {24, -46}, {40, -46}}, color = {0, 0, 127}));
  connect(TempSupply, deltaT.u1) annotation(
    Line(points = {{2, 112}, {2, 86}, {40, 86}, {40, -34}}, color = {0, 0, 127}));
  connect(MassFlow.m_flow, Q_flow_calculated.u[3]) annotation(
    Line(points = {{-38, 65}, {-38, 78}, {86, 78}, {86, -36.6}, {110, -36.6}}, color = {0, 0, 127}));
  connect(Q_flow_calculated.y, Q_flow) annotation(
    Line(points = {{123.02, -38}, {122, -38}, {122, -110}, {6, -110}}, color = {0, 0, 127}));
  connect(hea1.port_a, sou2.ports[1]) annotation(
    Line(points = {{-40, -82}, {-130, -82}, {-130, -68}}, color = {0, 127, 255}));
 connect(hea1.port_b, bou1.ports[1]) annotation(
    Line(points = {{-20, -82}, {96, -82}, {96, -84}}, color = {0, 127, 255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ThermalPowerFlowSensor;
