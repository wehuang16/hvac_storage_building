within hvac_storage_building.Examples.BaseClasses;
block TankSOC
      parameter Real TankFullTemperature=273.15+53 "K";
  parameter Real TankEmptyTemperature=273.15+28 "K";
  Buildings.Controls.OBC.CDL.Reals.Line lin(limitBelow=false, limitAbove=false)
    annotation (Placement(transformation(extent={{-12,-8},{8,12}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TTan
    annotation (Placement(transformation(extent={{-142,-20},{-102,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput socTan
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=TankEmptyTemperature)
    annotation (Placement(transformation(extent={{-60,28},{-40,48}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0)
    annotation (Placement(transformation(extent={{-92,12},{-72,32}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=TankFullTemperature)
    annotation (Placement(transformation(extent={{-66,-34},{-46,-14}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=1)
    annotation (Placement(transformation(extent={{-34,-46},{-14,-26}})));
equation
  connect(TTan, lin.u) annotation (Line(points={{-122,0},{-22,0},{-22,2},{-14,2}},
        color={0,0,127}));
  connect(lin.y, socTan)
    annotation (Line(points={{10,2},{96,2},{96,0},{120,0}}, color={0,0,127}));
  connect(con.y, lin.x1) annotation (Line(points={{-38,38},{-22,38},{-22,10},{
          -14,10}}, color={0,0,127}));
  connect(con1.y, lin.f1) annotation (Line(points={{-70,22},{-24,22},{-24,6},{
          -14,6}}, color={0,0,127}));
  connect(con2.y, lin.x2) annotation (Line(points={{-44,-24},{-24,-24},{-24,-2},
          {-14,-2}}, color={0,0,127}));
  connect(con3.y, lin.f2) annotation (Line(points={{-12,-36},{-4,-36},{-4,-14},
          {-14,-14},{-14,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TankSOC;
