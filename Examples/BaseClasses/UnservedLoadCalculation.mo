within hvac_storage_building.Examples.BaseClasses;
block UnservedLoadCalculation
  Buildings.Controls.OBC.CDL.Interfaces.RealInput ZonLoaReq annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,60})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput ZonLoaAct
    annotation (Placement(transformation(extent={{-140,-80},{-100,-38}})));
  SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy
    annotation (Placement(transformation(extent={{-56,50},{-36,70}})));
  SeparateHeatingCoolingThermalEnergy separateHeatingCoolingThermalEnergy1
    annotation (Placement(transformation(extent={{-58,-74},{-38,-54}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-2,30},{18,50}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub1
    annotation (Placement(transformation(extent={{4,-72},{24,-52}})));
  Buildings.Controls.OBC.CDL.Reals.Max max1
    annotation (Placement(transformation(extent={{44,22},{64,42}})));
  Buildings.Controls.OBC.CDL.Reals.Max max2
    annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{10,-16},{30,4}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub2
    annotation (Placement(transformation(extent={{94,-70},{114,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput ZonLoaUns
    "unserved zone load" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,0})));
equation
  connect(ZonLoaReq, separateHeatingCoolingThermalEnergy.EffectiveThermalEnergy)
    annotation (Line(points={{-120,60},{-58,60}}, color={0,0,127}));
  connect(ZonLoaAct, separateHeatingCoolingThermalEnergy1.EffectiveThermalEnergy)
    annotation (Line(points={{-120,-59},{-120,-60},{-70,-60},{-70,-64},{-60,-64}},
        color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.HeatingThermalEnergy, sub.u1)
    annotation (Line(points={{-34,63.6},{-12,63.6},{-12,46},{-4,46}}, color={0,
          0,127}));
  connect(separateHeatingCoolingThermalEnergy1.HeatingThermalEnergy, sub.u2)
    annotation (Line(points={{-36,-60.4},{-12,-60.4},{-12,34},{-4,34}}, color={
          0,0,127}));
  connect(separateHeatingCoolingThermalEnergy.CoolingThermalEnergy, sub1.u1)
    annotation (Line(points={{-34,54.2},{-34,24},{-6,24},{-6,-56},{2,-56}},
        color={0,0,127}));
  connect(separateHeatingCoolingThermalEnergy1.CoolingThermalEnergy, sub1.u2)
    annotation (Line(points={{-36,-69.8},{-36,-70},{-6,-70},{-6,-68},{2,-68}},
        color={0,0,127}));
  connect(sub.y, max1.u1) annotation (Line(points={{20,40},{34,40},{34,38},{42,
          38}}, color={0,0,127}));
  connect(sub1.y, max2.u2) annotation (Line(points={{26,-62},{44,-62},{44,-64},
          {52,-64}}, color={0,0,127}));
  connect(con.y, max1.u2) annotation (Line(points={{32,-6},{40,-6},{40,18},{42,
          18},{42,26}}, color={0,0,127}));
  connect(con.y, max2.u1) annotation (Line(points={{32,-6},{44,-6},{44,-52},{52,
          -52}}, color={0,0,127}));
  connect(max1.y, sub2.u1) annotation (Line(points={{66,32},{84,32},{84,-54},{
          92,-54}}, color={0,0,127}));
  connect(max2.y, sub2.u2) annotation (Line(points={{76,-58},{84,-58},{84,-66},
          {92,-66}}, color={0,0,127}));
  connect(sub2.y, ZonLoaUns) annotation (Line(points={{116,-60},{124,-60},{124,
          -24},{96,-24},{96,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end UnservedLoadCalculation;
