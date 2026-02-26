within hvac_storage_building.Examples.BaseClasses;
block ValueScaleDown

  parameter Real yAtZero=5;
  parameter Real yAtOne=10;
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Reals.Line lin
    annotation (Placement(transformation(extent={{24,6},{44,26}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=yAtZero)
    annotation (Placement(transformation(extent={{-66,84},{-46,104}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=0)
    annotation (Placement(transformation(extent={{-50,32},{-30,52}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=yAtOne)
    annotation (Placement(transformation(extent={{-68,-34},{-48,-14}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=1)
    annotation (Placement(transformation(extent={{-56,-78},{-36,-58}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
equation
  connect(con2.y,lin. x1) annotation (Line(points={{-44,94},{14,94},{14,24},{22,
          24}},       color={0,0,127}));
  connect(con3.y,lin. f1) annotation (Line(points={{-28,42},{12,42},{12,20},{22,
          20}},                 color={0,0,127}));
  connect(con4.y,lin. x2) annotation (Line(points={{-46,-24},{12,-24},{12,12},{22,
          12}},       color={0,0,127}));
  connect(con5.y,lin. f2)
    annotation (Line(points={{-34,-68},{14,-68},{14,8},{22,8}},
                                                           color={0,0,127}));
  connect(u, lin.u)
    annotation (Line(points={{-120,0},{8,0},{8,16},{22,16}}, color={0,0,127}));
  connect(lin.y, y) annotation (Line(points={{46,16},{94,16},{94,0},{120,0}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ValueScaleDown;
