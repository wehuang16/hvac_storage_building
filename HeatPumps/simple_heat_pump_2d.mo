within hvac_storage_building.HeatPumps;

model simple_heat_pump_2d
  replaceable package Medium_con = Buildings.Media.Water;
  package MediumPropyleneGlycol = Buildings.Media.Antifreeze.PropyleneGlycolWater(property_T = 273.15 + 20, X_a = 0.4);
  parameter Modelica.Units.SI.MassFlowRate mCon_flow_nominal = 0.5;
  parameter Modelica.Units.SI.Volume heat_pump_condenser_evaporator_volume = 0.005;
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium_con) annotation(
    Placement(transformation(origin = {196, -2}, extent = {{96, 48}, {116, 68}}), iconTransformation(origin = {200, 2}, extent = {{98, 22}, {118, 42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium_con) annotation(
    Placement(transformation(extent = {{-112, 46}, {-92, 66}}), iconTransformation(extent = {{-120, 24}, {-100, 44}})));
  Modelica.Blocks.Interfaces.RealInput TSupSetHea annotation(
    Placement(transformation(origin = {2, 16}, extent = {{-126, -142}, {-102, -118}}), iconTransformation(extent = {{-124, -140}, {-102, -118}})));
  Modelica.Blocks.Interfaces.BooleanInput HeaPumMod "Current operation mode: true: main operation mode, false: reversible operation mode" annotation(
    Placement(transformation(origin = {196, 16}, extent = {{126, -14}, {102, 10}}), iconTransformation(origin = {200, -10}, extent = {{124, -28}, {100, -4}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium = Medium_con, m_flow_nominal = mCon_flow_nominal) annotation(
    Placement(transformation(extent = {{56, 46}, {76, 66}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium = Medium_con, m_flow_nominal = mCon_flow_nominal) annotation(
    Placement(transformation(extent = {{-56, 74}, {-36, 94}})));
  Modelica.Blocks.Interfaces.BooleanInput HeaPumOnOff annotation(
    Placement(transformation(origin = {-112, 32}, extent = {{12, -12}, {-12, 12}}, rotation = 180), iconTransformation(origin = {-112, -6}, extent = {{12, -12}, {-12, 12}}, rotation = 180)));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_con) annotation(
    Placement(transformation(extent = {{-86, 50}, {-66, 70}})));
  Buildings.Controls.Continuous.LimPID conPID(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.3, Ti = 900, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.2, reverseActing = true) annotation(
    Placement(transformation(extent = {{54, -52}, {74, -32}})));
  Modelica.Blocks.Sources.Constant const(final k = 0) annotation(
    Placement(transformation(origin = {48, -176}, extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Modelica.Blocks.Logical.Switch OnOffSwitch annotation(
    Placement(transformation(extent = {{96, -66}, {116, -46}})));
  Modelica.Blocks.Math.Gain gain(k = -1) annotation(
    Placement(transformation(origin = {-98, 426}, extent = {{294, -166}, {314, -146}})));
  Buildings.Controls.Continuous.LimPID conPID1(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.3, Ti = 900, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0.2, reverseActing = false) annotation(
    Placement(transformation(extent = {{52, -96}, {72, -76}})));
  Modelica.Blocks.Interfaces.RealInput COPHea annotation(
    Placement(transformation(extent = {{-124, -32}, {-100, -8}}), iconTransformation(extent = {{-122, -58}, {-100, -36}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow annotation(
    Placement(transformation(origin = {60, 212}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {-29, 211}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput Pel annotation(
    Placement(transformation(origin = {104, 212}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {19, 211}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
  Buildings.Controls.OBC.CDL.Reals.Divide div1 annotation(
    Placement(transformation(origin = {-16, -4}, extent = {{-54, -14}, {-34, 6}})));
  Modelica.Blocks.Interfaces.RealInput MaxHeaPumCapHea annotation(
    Placement(transformation(origin = {0, 54}, extent = {{-124, 120}, {-100, 144}}), iconTransformation(origin = {0, 60}, extent = {{-122, 122}, {-100, 144}})));
  Modelica.Blocks.Interfaces.RealOutput compressor_speed annotation(
    Placement(transformation(origin = {140, 212}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {69, 211}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium = Medium_con, m_flow_nominal = mCon_flow_nominal, V = heat_pump_condenser_evaporator_volume, nPorts = 2) annotation(
    Placement(transformation(extent = {{-10, 62}, {10, 82}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo annotation(
    Placement(transformation(extent = {{-12, 22}, {8, 42}})));
  Modelica.Blocks.Logical.Switch OnOffSwitch1 annotation(
    Placement(transformation(extent = {{82, -140}, {102, -120}})));
  Modelica.Blocks.Interfaces.RealInput MaxHeaPumCapCoo annotation(
    Placement(transformation(origin = {10, 66}, extent = {{-134, 78}, {-110, 102}}), iconTransformation(origin = {0, 66}, extent = {{-122, 80}, {-100, 102}})));
  Modelica.Blocks.Interfaces.RealInput COPCoo annotation(
    Placement(transformation(extent = {{-124, -66}, {-100, -42}}), iconTransformation(extent = {{-122, -100}, {-100, -78}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi annotation(
    Placement(transformation(origin = {324, 120}, extent = {{-80, 148}, {-60, 168}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi1 annotation(
    Placement(transformation(origin = {50, 6}, extent = {{-70, -54}, {-50, -34}})));
  Modelica.Blocks.Interfaces.RealOutput TSup annotation(
    Placement(transformation(origin = {180, 210}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {105, 211}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput TSupSetCoo annotation(
    Placement(transformation(origin = {2, -32}, extent = {{-126, -142}, {-102, -118}}), iconTransformation(origin = {2, -42}, extent = {{-124, -140}, {-102, -118}})));
  Modelica.Blocks.Interfaces.RealInput MinHeaPumCapHea annotation(
    Placement(transformation(origin = {1, -6}, extent = {{-124, 120}, {-100, 144}}), iconTransformation(origin = {-1, -16}, extent = {{-122, 122}, {-100, 144}})));
  Modelica.Blocks.Interfaces.RealInput MinHeaPumCapCoo annotation(
    Placement(transformation(origin = {11, 6}, extent = {{-134, 78}, {-110, 102}}), iconTransformation(origin = {1, -8}, extent = {{-122, 80}, {-100, 102}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul1 annotation(
    Placement(transformation(origin = {11, 7}, extent = {{-32, 178}, {-12, 198}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi2 annotation(
    Placement(transformation(origin = {221, 10}, extent = {{-80, 148}, {-60, 168}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre annotation(
    Placement(transformation(origin = {48, 174}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const1(final k = 0) annotation(
    Placement(transformation(origin = {77, 153}, extent = {{8, 8}, {-8, -8}}, rotation = 180)));
  Buildings.Controls.OBC.CDL.Reals.Divide div annotation(
    Placement(transformation(origin = {208, 166}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul11 annotation(
    Placement(transformation(origin = {15, -40}, extent = {{-32, 178}, {-12, 198}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre1 annotation(
    Placement(transformation(origin = {52, 120}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi21 annotation(
    Placement(transformation(origin = {234, -43}, extent = {{-80, 148}, {-60, 168}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div2 annotation(
    Placement(transformation(origin = {220, 112}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi22 annotation(
    Placement(transformation(origin = {317, -6}, extent = {{-80, 148}, {-60, 168}})));
  Buildings.Controls.OBC.CDL.Reals.Divide div11 annotation(
    Placement(transformation(origin = {-6, -53}, extent = {{-54, -14}, {-34, 6}})));
equation
  connect(TWatSup.port_b, port_b) annotation(
    Line(points = {{76, 56}, {302, 56}}, color = {0, 127, 255}));
  connect(port_a, senMasFlo.port_a) annotation(
    Line(points = {{-102, 56}, {-94, 56}, {-94, 60}, {-86, 60}}, color = {0, 127, 255}));
  connect(senMasFlo.port_b, TWatRet.port_a) annotation(
    Line(points = {{-66, 60}, {-62, 60}, {-62, 84}, {-56, 84}}, color = {0, 127, 255}));
  connect(const.y, OnOffSwitch.u3) annotation(
    Line(points = {{57, -176}, {106.2, -176}, {106, -72}, {94, -72}, {94, -64}}, color = {0, 0, 127}));
  connect(HeaPumOnOff, OnOffSwitch.u2) annotation(
    Line(points = {{-112, 32}, {-54, 32}, {-54, 16}, {84, 16}, {84, -56}, {94, -56}}, color = {255, 0, 255}));
  connect(TSupSetHea, conPID.u_s) annotation(
    Line(points = {{-112, -114}, {42, -114}, {42, -42}, {52, -42}}, color = {0, 0, 127}));
  connect(TWatSup.T, conPID.u_m) annotation(
    Line(points = {{66, 67}, {66, 68}, {26, 68}, {26, -64}, {64, -64}, {64, -54}}, color = {0, 0, 127}));
  connect(TWatSup.T, conPID1.u_m) annotation(
    Line(points = {{66, 67}, {46, 67}, {46, 68}, {26, 68}, {26, -98}, {62, -98}}, color = {0, 0, 127}));
  connect(preHeaFlo.port, vol.heatPort) annotation(
    Line(points = {{8, 32}, {14, 32}, {14, 56}, {-16, 56}, {-16, 72}, {-10, 72}}, color = {191, 0, 0}));
  connect(TWatRet.port_b, vol.ports[1]) annotation(
    Line(points = {{-36, 84}, {-32, 84}, {-32, 54}, {-1, 54}, {-1, 62}}, color = {0, 127, 255}));
  connect(TWatSup.port_a, vol.ports[2]) annotation(
    Line(points = {{56, 56}, {30, 56}, {30, 54}, {1, 54}, {1, 62}}, color = {0, 127, 255}));
  connect(conPID.y, OnOffSwitch.u1) annotation(
    Line(points = {{75, -42}, {86, -42}, {86, -48}, {94, -48}}, color = {0, 0, 127}));
  connect(conPID1.y, OnOffSwitch1.u1) annotation(
    Line(points = {{73, -86}, {78, -86}, {78, -114}, {80, -114}, {80, -122}}, color = {0, 0, 127}));
  connect(const.y, OnOffSwitch1.u3) annotation(
    Line(points = {{57, -176}, {72, -176}, {72, -138}, {80, -138}}, color = {0, 0, 127}));
  connect(HeaPumOnOff, OnOffSwitch1.u2) annotation(
    Line(points = {{-112, 32}, {-112, -130}, {80, -130}}, color = {255, 0, 255}));
  connect(HeaPumMod, swi1.u2) annotation(
    Line(points = {{310, 14}, {150, 14}, {150, -70}, {-72, -70}, {-72, -38}, {-22, -38}}, color = {255, 0, 255}));
  connect(TWatSup.T, TSup) annotation(
    Line(points = {{66, 67}, {66, 76}, {180, 76}, {180, 210}}, color = {0, 0, 127}));
  connect(conPID1.u_s, TSupSetCoo) annotation(
    Line(points = {{50, -86}, {-94, -86}, {-94, -162}, {-112, -162}}, color = {0, 0, 127}));
  connect(MaxHeaPumCapHea, mul1.u1) annotation(
    Line(points = {{-112, 186}, {-68, 186}, {-68, 204}, {-50, 204}, {-50, 201}, {-23, 201}}, color = {0, 0, 127}));
  connect(mul1.u2, OnOffSwitch.y) annotation(
    Line(points = {{-23, 189}, {122, 189}, {122, -56}, {118, -56}}, color = {0, 0, 127}));
  connect(gre.u1, mul1.y) annotation(
    Line(points = {{36, 174}, {1, 174}, {1, 195}}, color = {0, 0, 127}));
  connect(MinHeaPumCapHea, gre.u2) annotation(
    Line(points = {{-110, 126}, {36, 126}, {36, 166}}, color = {0, 0, 127}));
  connect(gre.y, swi2.u2) annotation(
    Line(points = {{60, 174}, {140, 174}, {140, 168}}, color = {255, 0, 255}));
  connect(mul1.y, swi2.u1) annotation(
    Line(points = {{1, 195}, {22, 195}, {22, 176}, {140, 176}}, color = {0, 0, 127}));
  connect(const1.y, swi2.u3) annotation(
    Line(points = {{86, 153}, {140, 153}, {140, 160}}, color = {0, 0, 127}));
  connect(swi2.y, div.u1) annotation(
    Line(points = {{164, 168}, {196, 168}, {196, 172}}, color = {0, 0, 127}));
  connect(MaxHeaPumCapHea, div.u2) annotation(
    Line(points = {{-112, 186}, {192, 186}, {192, 160}, {196, 160}}, color = {0, 0, 127}));
  connect(MaxHeaPumCapCoo, mul11.u1) annotation(
    Line(points = {{-112, 156}, {-18, 156}, {-18, 154}}, color = {0, 0, 127}));
  connect(OnOffSwitch1.y, mul11.u2) annotation(
    Line(points = {{104, -130}, {144, -130}, {144, 132}, {-18, 132}, {-18, 142}}, color = {0, 0, 127}));
  connect(mul11.y, gre1.u1) annotation(
    Line(points = {{6, 148}, {24, 148}, {24, 120}, {40, 120}}, color = {0, 0, 127}));
  connect(MinHeaPumCapCoo, gre1.u2) annotation(
    Line(points = {{-110, 96}, {40, 96}, {40, 112}}, color = {0, 0, 127}));
  connect(gre1.y, swi21.u2) annotation(
    Line(points = {{64, 120}, {152, 120}, {152, 116}}, color = {255, 0, 255}));
  connect(swi21.u1, mul11.y) annotation(
    Line(points = {{152, 124}, {6, 124}, {6, 148}}, color = {0, 0, 127}));
  connect(const1.y, swi21.u3) annotation(
    Line(points = {{86, 154}, {90, 154}, {90, 108}, {152, 108}}, color = {0, 0, 127}));
  connect(swi21.y, div2.u1) annotation(
    Line(points = {{176, 116}, {208, 116}, {208, 118}}, color = {0, 0, 127}));
  connect(MaxHeaPumCapCoo, div2.u2) annotation(
    Line(points = {{-112, 156}, {190, 156}, {190, 106}, {208, 106}}, color = {0, 0, 127}));
  connect(div2.y, swi22.u3) annotation(
    Line(points = {{232, 112}, {236, 112}, {236, 144}}, color = {0, 0, 127}));
  connect(div.y, swi22.u1) annotation(
    Line(points = {{220, 166}, {236, 166}, {236, 160}}, color = {0, 0, 127}));
  connect(swi22.u2, HeaPumMod) annotation(
    Line(points = {{236, 152}, {208, 152}, {208, 14}, {310, 14}}, color = {255, 0, 255}));
  connect(swi22.y, compressor_speed) annotation(
    Line(points = {{260, 152}, {258, 152}, {258, 228}, {140, 228}, {140, 212}}, color = {0, 0, 127}));
  connect(gain.y, swi.u3) annotation(
    Line(points = {{217, 270}, {242, 270}}, color = {0, 0, 127}));
  connect(swi.u2, HeaPumMod) annotation(
    Line(points = {{242, 278}, {226, 278}, {226, 14}, {310, 14}}, color = {255, 0, 255}));
  connect(swi2.y, swi.u1) annotation(
    Line(points = {{164, 168}, {164, 286}, {242, 286}}, color = {0, 0, 127}));
  connect(swi21.y, gain.u) annotation(
    Line(points = {{176, 116}, {194, 116}, {194, 270}}, color = {0, 0, 127}));
  connect(swi.y, Q_flow) annotation(
    Line(points = {{266, 278}, {304, 278}, {304, 256}, {60, 256}, {60, 212}}, color = {0, 0, 127}));
  connect(swi.y, preHeaFlo.Q_flow) annotation(
    Line(points = {{266, 278}, {332, 278}, {332, 22}, {-12, 22}, {-12, 32}}, color = {0, 0, 127}));
  connect(div1.u2, COPHea) annotation(
    Line(points = {{-72, -14}, {-112, -14}, {-112, -20}}, color = {0, 0, 127}));
  connect(swi2.y, div1.u1) annotation(
    Line(points = {{164, 168}, {160, 168}, {160, 10}, {-72, 10}, {-72, -2}}, color = {0, 0, 127}));
  connect(COPCoo, div11.u2) annotation(
    Line(points = {{-112, -54}, {-62, -54}, {-62, -62}}, color = {0, 0, 127}));
  connect(swi21.y, div11.u1) annotation(
    Line(points = {{176, 116}, {166, 116}, {166, -50}, {-62, -50}}, color = {0, 0, 127}));
  connect(div1.y, swi1.u1) annotation(
    Line(points = {{-48, -8}, {-22, -8}, {-22, -30}}, color = {0, 0, 127}));
  connect(div11.y, swi1.u3) annotation(
    Line(points = {{-38, -56}, {-22, -56}, {-22, -46}}, color = {0, 0, 127}));
  connect(swi1.y, Pel) annotation(
    Line(points = {{2, -38}, {104, -38}, {104, 212}}, color = {0, 0, 127}));
equation

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -200}, {300, 200}})),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -200}, {300, 200}})),
    Documentation(info = "<html>
<p>In reverse operation mode, the condenser becomes the evaporator, and the evaporator becomes the condenser.</p>
</html>"));
end simple_heat_pump_2d;
