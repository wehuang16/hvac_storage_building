within hvac_storage_building.HeatPumps.BaseClasses;
model heat_pump_cycling_timer_controller

  parameter Modelica.Units.SI.Time cycling_wait_time = 600;
  Modelica.Blocks.Interfaces.RealInput MinHeaPumCap annotation (Placement(
        transformation(origin={-1,-112}, extent={{-124,120},{-100,144}}),
        iconTransformation(origin={-1,-116}, extent={{-122,122},{-100,144}})));
  Modelica.Blocks.Interfaces.RealInput QHeaPum_flow_request annotation (
      Placement(transformation(origin={-1,-178}, extent={{-124,120},{-100,144}}),
        iconTransformation(origin={-1,-176}, extent={{-122,122},{-100,144}})));
  Modelica.Blocks.Interfaces.RealOutput QHeaPum_flow_command annotation (
      Placement(transformation(origin={223,-132}, extent={{-124,120},{-100,144}}),
        iconTransformation(origin={223,-132}, extent={{-122,122},{-100,144}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=0)
    annotation (Placement(transformation(extent={{-160,-108},{-140,-88}})));
  Buildings.Controls.OBC.CDL.Reals.Greater gre
    annotation (Placement(transformation(extent={{-42,-16},{-22,4}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=
        cycling_wait_time)
    annotation (Placement(transformation(extent={{18,-26},{38,-6}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swi
    annotation (Placement(transformation(extent={{76,-38},{96,-18}})));
  Buildings.Controls.OBC.CDL.Reals.MovingAverage movAve(delta=300)
    annotation (Placement(transformation(extent={{114,-60},{134,-40}})));
equation
  connect(QHeaPum_flow_request, gre.u1) annotation (Line(points={{-113,-46},{-54,
          -46},{-54,-6},{-44,-6}}, color={0,0,127}));
  connect(MinHeaPumCap, gre.u2) annotation (Line(points={{-113,20},{-52,20},{-52,
          -14},{-44,-14}}, color={0,0,127}));
  connect(gre.y, truDel.u) annotation (Line(points={{-20,-6},{10,-6},{10,-16},{16,
          -16}}, color={255,0,255}));
  connect(truDel.y, swi.u2) annotation (Line(points={{40,-16},{64,-16},{64,-28},
          {74,-28}}, color={255,0,255}));
  connect(con1.y, swi.u3) annotation (Line(points={{-138,-98},{66,-98},{66,-36},
          {74,-36}}, color={0,0,127}));
  connect(QHeaPum_flow_request, swi.u1) annotation (Line(points={{-113,-46},{-54,
          -46},{-54,2},{-46,2},{-46,8},{66,8},{66,-20},{74,-20}}, color={0,0,127}));
  connect(swi.y, movAve.u) annotation (Line(points={{98,-28},{106,-28},{106,-50},
          {112,-50}}, color={0,0,127}));
  connect(movAve.y, QHeaPum_flow_command) annotation (Line(points={{136,-50},{
          144,-50},{144,0},{111,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end heat_pump_cycling_timer_controller;
