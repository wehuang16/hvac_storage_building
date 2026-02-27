within hvac_storage_building.Examples.BaseClasses;
block VolumizerLoss


    parameter Real heatLossRate=0.5 "heat loss rate in W/K";
  Buildings.HeatTransfer.Convection.Interior con1(A=1, hFixed=heatLossRate,
    til=0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={32,2})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature TA
    "Temperature boundary condition"
    annotation (Placement(transformation(extent={{-28,-8},{-8,12}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput outside_air_temperature
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
equation
  connect(outside_air_temperature, TA.T) annotation (Line(points={{-120,0},{-38,
          0},{-38,2},{-30,2}}, color={0,0,127}));
  connect(TA.port, con1.fluid)
    annotation (Line(points={{-8,2},{22,2}}, color={191,0,0}));
  connect(con1.solid, port_a)
    annotation (Line(points={{42,2},{92,2},{92,0},{106,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VolumizerLoss;
