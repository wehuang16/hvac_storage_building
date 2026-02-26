within hvac_storage_building.Examples.BaseClasses;
block ZoneThermalMode
  parameter Real smallThermalPowerLimit=1 "in W";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput zone_load_request annotation
    (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yZonHeaCooMod
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold greThr(t=
        smallThermalPowerLimit)
    annotation (Placement(transformation(extent={{-56,36},{-36,56}})));
  Buildings.Controls.OBC.CDL.Reals.LessThreshold lesThr(t=-1*
        smallThermalPowerLimit)
    annotation (Placement(transformation(extent={{-58,-42},{-38,-22}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{30,34},{50,54}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{10,-42},{30,-22}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=1)
    annotation (Placement(transformation(extent={{-16,70},{4,90}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=-1)
    annotation (Placement(transformation(extent={{-26,2},{-6,22}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=0)
    annotation (Placement(transformation(extent={{-24,-90},{-4,-70}})));
equation
  connect(zone_load_request, greThr.u) annotation (Line(points={{-120,0},{-68,0},
          {-68,46},{-58,46}}, color={0,0,127}));
  connect(zone_load_request, lesThr.u) annotation (Line(points={{-120,0},{-70,0},
          {-70,-32},{-60,-32}}, color={0,0,127}));
  connect(greThr.y, intSwi.u2) annotation (Line(points={{-34,46},{20,46},{20,44},
          {28,44}}, color={255,0,255}));
  connect(lesThr.y, intSwi1.u2)
    annotation (Line(points={{-36,-32},{8,-32}}, color={255,0,255}));
  connect(intSwi1.y, intSwi.u3) annotation (Line(points={{32,-32},{40,-32},{40,
          26},{28,26},{28,36}}, color={255,127,0}));
  connect(conInt.y, intSwi.u1) annotation (Line(points={{6,80},{20,80},{20,52},
          {28,52}}, color={255,127,0}));
  connect(conInt1.y, intSwi1.u1)
    annotation (Line(points={{-4,12},{8,12},{8,-24}}, color={255,127,0}));
  connect(conInt2.y, intSwi1.u3) annotation (Line(points={{-2,-80},{6,-80},{6,
          -48},{8,-48},{8,-40}}, color={255,127,0}));
  connect(intSwi.y, yZonHeaCooMod) annotation (Line(points={{52,44},{94,44},{94,
          0},{120,0}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ZoneThermalMode;
