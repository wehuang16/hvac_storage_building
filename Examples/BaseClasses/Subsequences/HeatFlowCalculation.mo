within hvac_storage_building.Examples.BaseClasses.Subsequences;
block HeatFlowCalculation
  parameter Real cp=4184 "fluid heat capacity";
  Buildings.Controls.OBC.CDL.Interfaces.RealInput m_flow
    annotation (Placement(transformation(extent={{-140,54},{-100,94}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput T_in
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput T_out
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput Q_input
    "positive if heat flows into the hot PCM"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Buildings.Controls.OBC.CDL.Reals.Subtract sub
    annotation (Placement(transformation(extent={{-44,-52},{-24,-32}})));
  Buildings.Controls.OBC.CDL.Reals.Multiply mul
    annotation (Placement(transformation(extent={{12,0},{32,20}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=cp)
    annotation (Placement(transformation(extent={{58,-2},{78,18}})));
equation
  connect(T_in, sub.u1) annotation (Line(points={{-120,0},{-84,0},{-84,-36},{
          -46,-36}}, color={0,0,127}));
  connect(T_out, sub.u2) annotation (Line(points={{-120,-80},{-83,-80},{-83,-48},
          {-46,-48}}, color={0,0,127}));
  connect(m_flow, mul.u1) annotation (Line(points={{-120,74},{-56,74},{-56,16},
          {10,16}}, color={0,0,127}));
  connect(sub.y, mul.u2) annotation (Line(points={{-22,-42},{-22,-19},{10,-19},
          {10,4}}, color={0,0,127}));
  connect(mul.y, gai.u)
    annotation (Line(points={{34,10},{46,10},{46,8},{56,8}}, color={0,0,127}));
  connect(gai.y, Q_input)
    annotation (Line(points={{80,8},{92,8},{92,0},{120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatFlowCalculation;
