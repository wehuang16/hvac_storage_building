within hvac_storage_building.Examples.BaseClasses;
block ValueScaleDown

  parameter Real uAtZero=5;
  parameter Real uAtOne=10;
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Reals.Line lin
    annotation (Placement(transformation(extent={{24,6},{44,26}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=uAtZero)
    annotation (Placement(transformation(extent={{-66,84},{-46,104}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=0)
    annotation (Placement(transformation(extent={{-50,32},{-30,52}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con4(k=uAtOne)
    annotation (Placement(transformation(extent={{-86,-8},{-66,12}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con5(k=1)
    annotation (Placement(transformation(extent={{-56,-32},{-36,-12}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uValToSca "value to scale"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yValSca
    "resulting value after scale"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
equation
  connect(con2.y,lin. x1) annotation (Line(points={{-44,94},{14,94},{14,24},{22,
          24}},       color={0,0,127}));
  connect(con3.y,lin. f1) annotation (Line(points={{-28,42},{12,42},{12,20},{22,
          20}},                 color={0,0,127}));
  connect(con4.y,lin. x2) annotation (Line(points={{-64,2},{12,2},{12,12},{22,
          12}},       color={0,0,127}));
  connect(con5.y,lin. f2)
    annotation (Line(points={{-34,-22},{14,-22},{14,8},{22,8}},
                                                           color={0,0,127}));
  connect(u, lin.u)
    annotation (Line(points={{-120,40},{-56,40},{-56,16},{22,16}},
                                                             color={0,0,127}));
  connect(lin.y, y) annotation (Line(points={{46,16},{94,16},{94,40},{120,40}},
        color={0,0,127}));
  connect(lin.y, mul.u1)
    annotation (Line(points={{46,16},{58,16},{58,-34}}, color={0,0,127}));
  connect(uValToSca, mul.u2) annotation (Line(points={{-120,-40},{48,-40},{48,
          -46},{58,-46}}, color={0,0,127}));
  connect(mul.y, yValSca)
    annotation (Line(points={{82,-40},{120,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ValueScaleDown;
