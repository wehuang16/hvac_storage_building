within hvac_storage_building.Controls;

model hvac_storage_controller
 Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput chiller1On
    annotation (Placement(transformation(extent={{100,40},{140,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput secondaryPumpOn
    annotation (Placement(transformation(extent={{100,-48},{140,-8}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput systemCommand
    "1=baseline; 2=charge TES; 3=discharge TES"
    annotation (Placement(transformation(extent={{-140,58},{-100,98}})));
  Modelica.Blocks.Tables.CombiTable1Ds equipmentControl(table=[0,0,0,0,0; 1,1,0,
        1,0; 2,0,1,0,1; 3,0,0,1,0],                        extrapolation=
        Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{8,-20},{28,0}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=0.5)
    annotation (Placement(transformation(extent={{50,50},{70,70}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr2(t=0.5)
    annotation (Placement(transformation(extent={{54,-42},{74,-22}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput tesStatus
    "1=has capacity; 0=fully discharged"
    annotation (Placement(transformation(extent={{-142,-44},{-102,-4}})));
  Modelica.Blocks.Tables.CombiTable2Ds systemModePre(table=[-999,0,1; 0,0,0; 1,
        0,1; 2,2,2; 3,0,3],
                extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    "0=do nothing; 1=chiller serves load; 2=chiller charge tes; 3= tes serves load; 4=hybrid charge; 5=hybrid serves"
    annotation (Placement(transformation(extent={{-36,46},{-16,66}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput loadRequest
    "1=heating; 0=deadband; -1=cooling"
    annotation (Placement(transformation(origin = {0, -12}, extent = {{-140, 18}, {-100, 58}}), iconTransformation(extent = {{-140, 18}, {-100, 58}})));
  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea1
    annotation (Placement(transformation(extent={{-78,-70},{-58,-50}})));
  Modelica.Blocks.Tables.CombiTable2Ds systemModeFinal(table=[0,-1,0,1; 0,0,0,0;
        1,1,1,1; 2,2,2,2; 3,1,3,3],          extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation)
    annotation (Placement(transformation(extent={{-24,-54},{-4,-34}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput systemMode
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,120})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput chiller2On
    annotation (Placement(transformation(extent={{100,-8},{140,32}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput bypassPumpOn
    annotation (Placement(transformation(extent={{100,-102},{140,-62}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr1(t=0.5)
    annotation (Placement(transformation(extent={{60,6},{80,26}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr3(t=0.5)
    annotation (Placement(transformation(extent={{60,-96},{80,-76}})));
 Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea2 annotation(
    Placement(transformation(origin = {8, -48}, extent = {{-74, 44}, {-54, 64}})));
equation
  connect(systemCommand, intToRea.u) annotation(
    Line(points = {{-120, 78}, {-86, 78}, {-86, 54}, {-76, 54}}, color = {255, 127, 0}));
  connect(intToRea.y, systemModePre.u1) annotation(
    Line(points = {{-52, 54}, {-52, 72}, {-38, 72}, {-38, 62}}, color = {0, 0, 127}));
  connect(tesStatus, intToRea1.u) annotation(
    Line(points = {{-122, -24}, {-90, -24}, {-90, -60}, {-80, -60}}, color = {255, 127, 0}));
  connect(intToRea1.y, systemModeFinal.u2) annotation(
    Line(points = {{-56, -60}, {-36, -60}, {-36, -50}, {-26, -50}}, color = {0, 0, 127}));
  connect(greThr.y, chiller1On) annotation(
    Line(points = {{72, 60}, {120, 60}}, color = {255, 0, 255}));
  connect(greThr2.y, secondaryPumpOn) annotation(
    Line(points = {{76, -32}, {96, -32}, {96, -28}, {120, -28}}, color = {255, 0, 255}));
  connect(greThr3.y, bypassPumpOn) annotation(
    Line(points = {{82, -86}, {94, -86}, {94, -82}, {120, -82}}, color = {255, 0, 255}));
  connect(greThr1.y, chiller2On) annotation(
    Line(points = {{82, 16}, {94, 16}, {94, 12}, {120, 12}}, color = {255, 0, 255}));
 connect(loadRequest, intToRea2.u) annotation(
    Line(points = {{-120, 26}, {-68, 26}, {-68, 6}}, color = {255, 127, 0}));
end hvac_storage_controller;
