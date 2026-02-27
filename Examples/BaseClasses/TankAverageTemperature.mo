within hvac_storage_building.Examples.BaseClasses;
block TankAverageTemperature
  parameter Integer nSeg=20 "number of tank segments";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a[nSeg]
    annotation (Placement(transformation(extent={{-116,-10},{-96,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor[
    nSeg] annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
  Buildings.Controls.OBC.CDL.Reals.MultiSum mulSum(nin=nSeg)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Math.Gain gai(k=1/nSeg) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,0})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput avgTem annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={120,0})));
equation
  connect(port_a, temperatureSensor.port)
    annotation (Line(points={{-106,0},{-76,0}}, color={191,0,0}));
  connect(mulSum.u, temperatureSensor.T)
    annotation (Line(points={{-32,0},{-55,0}}, color={0,0,127}));
  connect(gai.u, mulSum.y)
    annotation (Line(points={{10,0},{-8,0}}, color={0,0,127}));
  connect(gai.y, avgTem)
    annotation (Line(points={{33,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TankAverageTemperature;
