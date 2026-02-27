within hvac_storage_building.Examples.BaseClasses;
block CoolingThermalStorageStatus

      parameter Real CoolingTankFullTemperature=273.15+10 "K";
  parameter Real CoolingTankEmptyTemperature=273.15+16 "K";

      parameter Real TankHysteresisTemperature=0.5 "K";

  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys(uLow=
        CoolingTankFullTemperature, uHigh=CoolingTankFullTemperature +
        TankHysteresisTemperature)
    annotation (Placement(transformation(extent={{-44,34},{-24,54}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TSto
    "thermal storage temperature"
    annotation (Placement(transformation(extent={{-142,-20},{-102,20}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis hys1(uLow=
        CoolingTankEmptyTemperature - TankHysteresisTemperature, uHigh=
        CoolingTankEmptyTemperature)
    annotation (Placement(transformation(extent={{-50,-68},{-30,-48}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-6,34},{14,54}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=1)
    annotation (Placement(transformation(extent={{4,74},{24,94}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi
    annotation (Placement(transformation(extent={{52,40},{72,60}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=-1)
    annotation (Placement(transformation(extent={{10,6},{30,26}})));
  Buildings.Controls.OBC.CDL.Integers.Switch intSwi1
    annotation (Placement(transformation(extent={{60,-44},{80,-24}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt2(k=0)
    annotation (Placement(transformation(extent={{26,-92},{46,-72}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yStoMod
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
equation
  connect(TSto, hys.u) annotation (Line(points={{-122,0},{-56,0},{-56,44},{-46,44}},
        color={0,0,127}));
  connect(TSto, hys1.u)
    annotation (Line(points={{-122,0},{-52,0},{-52,-58}}, color={0,0,127}));
  connect(conInt.y, intSwi.u1) annotation (Line(points={{26,84},{42,84},{42,58},
          {50,58}}, color={255,127,0}));
  connect(conInt1.y, intSwi1.u1) annotation (Line(points={{32,16},{50,16},{50,-26},
          {58,-26}}, color={255,127,0}));
  connect(conInt2.y, intSwi1.u3) annotation (Line(points={{48,-82},{56,-82},{56,
          -50},{58,-50},{58,-42}}, color={255,127,0}));
  connect(intSwi1.y, intSwi.u3) annotation (Line(points={{82,-34},{90,-34},{90,34},
          {50,34},{50,42}}, color={255,127,0}));
  connect(intSwi.y, yStoMod) annotation (Line(points={{74,50},{94,50},{94,0},{120,
          0}}, color={255,127,0}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-22,44},{-8,44}}, color={255,0,255}));
  connect(not1.y, intSwi.u2) annotation (Line(points={{16,44},{40,44},{40,50},{50,
          50}}, color={255,0,255}));
  connect(hys1.y, intSwi1.u2) annotation (Line(points={{-28,-58},{50,-58},{50,-34},
          {58,-34}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CoolingThermalStorageStatus;
